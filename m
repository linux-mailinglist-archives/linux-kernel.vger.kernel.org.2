Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8D1630D0F0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 02:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbhBCBnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 20:43:37 -0500
Received: from pv50p00im-tydg10011801.me.com ([17.58.6.52]:48132 "EHLO
        pv50p00im-tydg10011801.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229630AbhBCBnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 20:43:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1612316554;
        bh=6t1RFU17SOePPL6+ZA76bZtVpmVDB9u2nd5fGo71KuE=;
        h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
        b=ry7pyJsU1trJcwpLP98ZhCHb6nDA/p+5VfUqj1qxa908XEqGkrH4XQmgYf6vA6RjS
         qB6Alak7z9ag2TLIeGJBGdsHFgeGQDkcp0bQvcHFzwevd8aurzFvCzsKz9Se3Fwa9h
         XiCWor8/oS130ZKwvuwDyPthdXzn3aUVGceEoj/BKU3KPuPaPVmcPttq1LuJrlcCdp
         f9oslEQUizRxXY8CzmU9CW5DWh/SyZuNmSC/zxIeY8IAFRoQZahw9acNESEvb9iKBy
         flMqG0tGR2CyyPcy+WmqkKQMRS3dknathaazDdWDY5C1DubHr66BgeqDjxXaOqyej6
         TSzncdlSnC7Sg==
Received: from [11.240.15.70] (unknown [119.3.119.19])
        by pv50p00im-tydg10011801.me.com (Postfix) with ESMTPSA id D77EE66053D;
        Wed,  3 Feb 2021 01:42:31 +0000 (UTC)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.40.0.2.32\))
Subject: Re: [PATCH] mm/slub: embed __slab_alloc to its caller
From:   Abel Wu <abel.w@icloud.com>
In-Reply-To: <alpine.DEB.2.22.394.2102021009470.50959@www.lameter.com>
Date:   Wed, 3 Feb 2021 09:41:58 +0800
Cc:     Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, hewenliang4@huawei.com,
        wuyun.wu@huawei.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <9A811B32-6E3D-4FE1-98A5-A7922C32CDB4@icloud.com>
References: <20210202080515.2689-1-abel.w@icloud.com>
 <alpine.DEB.2.22.394.2102021009470.50959@www.lameter.com>
To:     Christoph Lameter <cl@linux.com>
X-Mailer: Apple Mail (2.3654.40.0.2.32)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-02_13:2021-02-02,2021-02-02 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=633 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2006250000 definitions=main-2102030005
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Feb 2, 2021, at 6:11 PM, Christoph Lameter <cl@linux.com> wrote:
> 
> On Tue, 2 Feb 2021, Abel Wu wrote:
> 
>> Since slab_alloc_node() is the only caller of __slab_alloc(), embed
>> __slab_alloc() to its caller to save function call overhead. This
>> will also expand the caller's code block size a bit, but hackbench
>> tests on both host and guest didn't show a difference w/ or w/o
>> this patch.
> 
> slab_alloc_node is an always_inline function. It is intentional that only
> the fast path was inlined and not the slow path.

Oh I got it. Thanks for your excellent explanation.

Best Regards,
	Abel
