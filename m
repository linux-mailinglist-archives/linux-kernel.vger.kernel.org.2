Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE81135392B
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Apr 2021 19:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbhDDR0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Apr 2021 13:26:22 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:47687 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231206AbhDDR0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Apr 2021 13:26:19 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 14636B4C;
        Sun,  4 Apr 2021 13:26:12 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 04 Apr 2021 13:26:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        to:cc:references:from:subject:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm2; bh=K
        ESy4hgR2flDtG6sCptQWSiEI0A7SilCBG9hlPjpaSw=; b=qmtMy8Fig6Vj9yZt6
        NRSMoIaTrtWbgWgeVqwiWjwio7vv3AFPVshbwmuv5MmusFNdBsQyxLgbFEnKEkDS
        S3yURF/KX0ax2dphJZlfV4qXddl/8KNsWJ40e09inGxPijW+tTA7tVsRpLPHBo49
        4GbNYoELEWIuvE9ygvLV9s6rh33aY2qgBW759BK8rjDi6iO0VpdPhirNz+Jznfvt
        tHCS6WggZo8djc13+3/rdNUVH4DJbQxEDZIyLZopoGtUpGJU/X/g03sd+SHNMrVR
        axrvh3XxUfRX7FXeU2A4yAZppUoCUjghMMwRugfGNQD56jypDzC7D7Na8125p06V
        FUoPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=KESy4hgR2flDtG6sCptQWSiEI0A7SilCBG9hlPjpa
        Sw=; b=ot+KrKN3R5Bxmo7TsBsAfa7S44aQvL2gXYDCaPYWDD0YgX+1OJfIVxQfB
        qVCF2c7aQMQRs1wjcGRkQyCsiDBpfYBNAu2EaKjjF5w+cqs2Q8i1bhGR38Cv0FNI
        gHSnzkyEC91KaEf4U3bCKK3wiyxZ+/QE6MRO81JCL0Tmmql9fGfCzVoS3zyd05DK
        M5VmLXq3IYGXa+yW1IjL04Tck2SisxgDoYo542RTOrtfgfG3fDvG6JQ1hXDEU1Zn
        2xUmM84H9IxUcmgu54+w4f3OsH0C5+jdoG6QVEjIGrdtQR2e4w++hJAAYuqrfolf
        ZT5DRZNkwWDdgKqIyLfIwO+6AreFw==
X-ME-Sender: <xms:s_ZpYEjP5lwxbLqLW4uLyGUuMqOVWieC_0IZtMJLEJA1tovi1rGKQA>
    <xme:s_ZpYNAN17qOrcGjXFLV8CBB9wPop59iIGFdUtcNrFJg-VG1rx_osVYpc8Cmv4YRR
    dwEm1ecN1QFiVozZw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudejtddguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefvfhfhuffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedvtddtjeeiuddugfffveetkeffgeffgedutdfgfeekudevudek
    ffehtdefveeuvdenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhl
    rghnugdrohhrgh
X-ME-Proxy: <xmx:s_ZpYMEZGtcol6RzTxs1jI2BJvztm38IYrFd1hfkC6hQ0g65OFFFTA>
    <xmx:s_ZpYFTJD2r7Ur0FVExDOT-GzmrSt2TX_0iy_8zQB5sw9eSH_NvFpA>
    <xmx:s_ZpYBz1TQXc_k8nZj5V_2UZZktH1cTsANGKBrIVKdK4uz94yTUXnw>
    <xmx:s_ZpYCorj9omk6pi18jMtdEhfJ-waem4o_XzrARJ4u5u-Dy5Q6dcAA>
Received: from [70.135.148.151] (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id F2A891080057;
        Sun,  4 Apr 2021 13:26:10 -0400 (EDT)
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Arend van Spriel <arend@broadcom.com>,
        linux-kernel@vger.kernel.org
References: <20210404004504.5547-1-samuel@sholland.org>
 <YGmQAWBN4+uQCIUa@kroah.com>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH] debugfs: Fix use-after-free in
 debugfs_create_devm_seqfile()
Message-ID: <2a36734b-c76c-7554-5f16-913ffebe288f@sholland.org>
Date:   Sun, 4 Apr 2021 12:26:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux ppc64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <YGmQAWBN4+uQCIUa@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/21 5:08 AM, Greg Kroah-Hartman wrote:
> On Sat, Apr 03, 2021 at 07:45:04PM -0500, Samuel Holland wrote:
>> This function uses devres to clean up its allocation, but it never removes the
>> file referencing that allocation. This causes a use-after-free and an oops if
>> the file is accessed after the owning device is removed.
> 
> What in-kernel user of this is having this problem?
> 
> The driver should clean up the debugfs file, it is not the debugfs
> core's job to auto-remove the file.

The function returns void. debugfs_remove() requires the dentry pointer,
which the caller does not have. How is the driver expected to clean up
the file?

Do you expect the driver to remove the file as a side effect of
recursively removing its parent? If so, that conflicts with the
documentation for debugfs_create_devm_seqfile(), which describes NULL as
a valid parent:

@parent: a pointer to the parent dentry for this file.  This should be a
     directory dentry if set.  If this parameter is %NULL, then the
     file will be created in the root of the debugfs filesystem.

There is one in-kernel caller that uses a NULL parent, in
drivers/gpio/gpio-tegra.c

> The resource is what is being cleaned up by the devm usage in debugfs,
> that's all, not the file.
> 
> Please fix up the driver that is creating the file but then not removing
> it.

In that case, the function documentation should be modified to state
that the driver is responsible for removing the parent directory, and
that NULL is not a valid parent here. I can send a patch doing that instead.

Samuel
