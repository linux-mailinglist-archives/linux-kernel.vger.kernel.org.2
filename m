Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D167E3CB89F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 16:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240253AbhGPOVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 10:21:21 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:56742 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232808AbhGPOVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 10:21:16 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R241e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UfzqysG_1626445099;
Received: from B-LB6YLVDL-0141.local(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0UfzqysG_1626445099)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 16 Jul 2021 22:18:20 +0800
Subject: Re: [PATCH] virtio-balloon: Use virtio_find_vqs() helper
To:     David Hildenbrand <david@redhat.com>,
        Xianting Tian <xianting_tian@126.com>, mst@redhat.com,
        jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <1626190724-7942-1-git-send-email-xianting_tian@126.com>
 <bbe52a89-c7ea-c155-6226-0397f223cd80@linux.alibaba.com>
 <95d7f688-79fc-05dc-87ca-da46e0179f0e@redhat.com>
 <58096b5a-8acb-a88f-c2c6-cd6e3201407f@redhat.com>
From:   tianxianting <xianting.tian@linux.alibaba.com>
Message-ID: <ab9ecc82-c3f6-6f34-1cdf-9605d0b285a8@linux.alibaba.com>
Date:   Fri, 16 Jul 2021 22:18:19 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <58096b5a-8acb-a88f-c2c6-cd6e3201407f@redhat.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

you really were in the ¡°to¡± list of my original email£º£©

ÔÚ 2021/7/16 ÏÂÎç9:10, David Hildenbrand Ð´µÀ:
> On 16.07.21 14:53, David Hildenbrand wrote:
>> On 16.07.21 14:46, tianxianting wrote:
>>> Do you interest in this patch? just little improvment:)
>>
>> I am, especially when I'm cc'ed and aware of it ;)
>>
>
> Sorry, just found it in my gmail spam folder ... WTH. Why does the 
> original one get filtered but not your ping ...
>
