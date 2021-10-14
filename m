Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B13C42D528
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 10:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbhJNIhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 04:37:09 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:52104 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230051AbhJNIhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 04:37:06 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0Urmp0Ip_1634200499;
Received: from B-LB6YLVDL-0141.local(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0Urmp0Ip_1634200499)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 14 Oct 2021 16:35:00 +0800
Subject: Re: [PATCH v10 2/3] tty: hvc: pass DMA capable memory to put_chars()
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     jirislaby@kernel.org, amit@kernel.org, arnd@arndb.de,
        osandov@fb.com, shile.zhang@linux.alibaba.com,
        linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20211009114829.1071021-1-xianting.tian@linux.alibaba.com>
 <20211009114829.1071021-3-xianting.tian@linux.alibaba.com>
 <YWGD8y9VfBIQBu2h@kroah.com>
 <3516c58c-e8e6-2e5a-2bc8-ad80e2124d37@linux.alibaba.com>
 <YWJ7NuapWOZ4QirJ@kroah.com>
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
Message-ID: <4dbeddb9-1068-d282-2758-55d0f788ea61@linux.alibaba.com>
Date:   Thu, 14 Oct 2021 16:34:59 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YWJ7NuapWOZ4QirJ@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/10/10 下午1:33, Greg KH 写道:
> On Sat, Oct 09, 2021 at 11:45:23PM +0800, Xianting Tian wrote:
>> 在 2021/10/9 下午7:58, Greg KH 写道:
>>> Did you look at the placement using pahole as to how this structure now
>>> looks?
>> thanks for all your commnts. for this one, do you mean I need to remove the
>> blank line?  thanks
>>
> No, I mean to use the tool 'pahole' to see the structure layout that you
> just created and determine if it really is the best way to add these new
> fields, especially as you are adding huge buffers with odd alignment.

thanks,

Based on your comments, I removed 'char outchar',  remian the position 
of 'int outbuf_size' unchanged to keep outbuf_size and lock in the same 
cache line.  Now hvc_struct change as below,

  struct hvc_struct {
         struct tty_port port;
         spinlock_t lock;
         int index;
         int do_wakeup;
-       char *outbuf;
         int outbuf_size;
         int n_outbuf;
         uint32_t vtermno;
@@ -48,6 +57,16 @@ struct hvc_struct {
         struct work_struct tty_resize;
         struct list_head next;
         unsigned long flags;
+
+       /*
+        * the buf is used in hvc console api for putting chars,
+        * and also used in hvc_poll_put_char() for putting single char.
+        */
+       char cons_outbuf[N_OUTBUF] __ALIGNED__;
+       spinlock_t cons_outbuf_lock;
+
+       /* the buf is used for putting chars to tty */
+       char outbuf[] __ALIGNED__;
  };

pahole for above hvc_struct as below,  is it ok for you?  do we need to 
pack the hole? thanks

struct hvc_struct {
     struct tty_port            port;                 /*     0 352 */
     /* --- cacheline 5 boundary (320 bytes) was 32 bytes ago --- */
     spinlock_t                 lock;                 /*   352 4 */
     int                        index;                /*   356 4 */
     int                        do_wakeup;            /*   360 4 */
     int                        outbuf_size;          /*   364 4 */
     int                        n_outbuf;             /*   368 4 */
     uint32_t                   vtermno;              /*   372 4 */
     const struct hv_ops  *     ops;                  /*   376 8 */
     /* --- cacheline 6 boundary (384 bytes) --- */
     int                        irq_requested;        /*   384 4 */
     int                        data;                 /*   388 4 */
     struct winsize             ws;                   /*   392 8 */
     struct work_struct         tty_resize;           /*   400 32 */
     struct list_head           next;                 /*   432 16 */
     /* --- cacheline 7 boundary (448 bytes) --- */
     long unsigned int          flags;                /*   448 8 */

     /* XXX 56 bytes hole, try to pack */

     /* --- cacheline 8 boundary (512 bytes) --- */
     char                       cons_outbuf[16];      /*   512 16 */
     spinlock_t                 cons_outbuf_lock;     /*   528 4 */

     /* XXX 44 bytes hole, try to pack */

     /* --- cacheline 9 boundary (576 bytes) --- */
     char                       outbuf[0];            /*   576 0 */

     /* size: 576, cachelines: 9, members: 17 */
     /* sum members: 476, holes: 2, sum holes: 100 */
};


>
> thanks,
>
> greg k-h
