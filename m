Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8B133EE64A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 07:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234300AbhHQFlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 01:41:15 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:33239 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233928AbhHQFlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 01:41:12 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R551e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0UjJea36_1629178837;
Received: from B-LB6YLVDL-0141.local(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0UjJea36_1629178837)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 17 Aug 2021 13:40:38 +0800
Subject: Re: [PATCH] mailbox: fix a UAF bug in msg_submit()
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        guoren@kernel.org
References: <20210806121521.124365-1-xianting.tian@linux.alibaba.com>
 <CABb+yY3i5aZQrimoWLTMQRY5WsOJ1FCGNxBN0Hz_=4qxUvoqSw@mail.gmail.com>
From:   Xianting TIan <xianting.tian@linux.alibaba.com>
Message-ID: <276286aa-b409-4506-563f-b8dc4f94b526@linux.alibaba.com>
Date:   Tue, 17 Aug 2021 13:40:37 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CABb+yY3i5aZQrimoWLTMQRY5WsOJ1FCGNxBN0Hz_=4qxUvoqSw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/8/17 下午12:29, Jassi Brar 写道:
> On Fri, Aug 6, 2021 at 7:15 AM Xianting Tian
> <xianting.tian@linux.alibaba.com> wrote:
>> We met a UAF issue during our mailbox testing.
>>
>> In synchronous mailbox, we use mbox_send_message() to send a message
>> and wait for completion. mbox_send_message() calls msg_submit() to
>> send the message for the first time, if timeout, it will send the
>> message in tx_tick() for the second time.
>>
> Seems like your controller's  .send_data() returns error. Can you
> please explain why it does so? Because
> send_data() only _accepts_ data for further transmission... which
> should seldom be a problem.


>
> thanks.
