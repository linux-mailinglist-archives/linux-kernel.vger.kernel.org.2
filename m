Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C36C33DB92B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 15:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238864AbhG3NSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 09:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbhG3NSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 09:18:15 -0400
Received: from mxout3.routing.net (mxout3.routing.net [IPv6:2a03:2900:1:a::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4EA1C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 06:18:10 -0700 (PDT)
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
        by mxout3.routing.net (Postfix) with ESMTP id C5B5B6048C;
        Fri, 30 Jul 2021 13:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1627651087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PkViEFXPVgM8mzZAi7UeLENFKB2DTHjszsn3u7Q4Bjw=;
        b=QWOfHaGc9aP6MbHjbleIXA+r3CvKttwF/YUremF7qxPrtEpwidg0bKmO2LTBac//+pb3VM
        icgNF2brx5d0gDnF9224jVc2kgsqsQMwG4BXqETRevG6cVN38c2HFEpjXXEpiUVerlc1u6
        QWilu+V5WqsqqrtL06YRVQgVMHnNeFA=
Received: from webmail.hosting.de (unknown [134.0.26.148])
        by mxbox2.masterlogin.de (Postfix) with ESMTPA id 50012100695;
        Fri, 30 Jul 2021 13:18:07 +0000 (UTC)
MIME-Version: 1.0
Date:   Fri, 30 Jul 2021 15:18:07 +0200
From:   "Frank Wunderlich (linux)" <linux@fw-web.de>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org,
        Frank Wunderlich <frank-w@public-files.de>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        yong.wu@mediatek.com
Subject: Re: [PATCH] iommu: check if group is NULL before remove device
In-Reply-To: <YO/hpPpu6Z526+Ia@8bytes.org>
References: <20210715071150.82157-1-linux@fw-web.de>
 <YO/hpPpu6Z526+Ia@8bytes.org>
Message-ID: <d8c1f7326e6427c33c5ea68bd68adced@fw-web.de>
X-Sender: linux@fw-web.de
User-Agent: Roundcube Webmail/1.3.16
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Mail-ID: e0c0c7cb-d211-4581-81e3-8adad627b420
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2021-07-15 09:20, schrieb Joerg Roedel:
> On Thu, Jul 15, 2021 at 09:11:50AM +0200, Frank Wunderlich wrote:
>> From: Frank Wunderlich <frank-w@public-files.de>
>> 
>> if probe is failing, iommu_group may be not initialized,
> 
> Sentences start with capital letters.
> 
> IOMMU patch subjects too, after the 'iommu:' prefix.
> 
>> so freeing it will result in NULL pointer access
> 
> Please describe in more detail how this NULL-ptr dereference is
> triggered.

in my case probe (mtk_iommu_probe_device called from 
__iommu_probe_device) is failing due to fwspec missing and then 
dev_iommu_free/iommu_fwspec_free is called, later 
iommu_group_remove_device with group=NULL

i think i've found problem:

iommu_probe_device:
     group = iommu_group_get(dev);
     if (!group) { //group is checked here for NULL but accessed later
         ret = -ENODEV;
         goto err_release; <<<
     }
err_release:<<<
     iommu_release_device(dev);

------------------------------------------------------------------------------
void iommu_release_device(struct device *dev)
{
...
     iommu_group_remove_device(dev);

------------------------------------------------------------------------------
void iommu_group_remove_device(struct device *dev)
{
     struct iommu_group *group = dev->iommu_group;
     struct group_device *tmp_device, *device = NULL;
...
     dev_info(dev, "Removing from iommu group %d\n", group->id); //crash 
as group is NULL and not checked
