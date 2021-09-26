Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3274185FB
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 05:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbhIZD2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Sep 2021 23:28:39 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:40447 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230349AbhIZD2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Sep 2021 23:28:38 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=wuzongyong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Upa9eNv_1632626820;
Received: from localhost(mailfrom:wuzongyong@linux.alibaba.com fp:SMTPD_---0Upa9eNv_1632626820)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 26 Sep 2021 11:27:01 +0800
Date:   Sun, 26 Sep 2021 11:27:01 +0800
From:   Wu Zongyong <wuzongyong@linux.alibaba.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, mst@redhat.com,
        wei.yang1@linux.alibaba.com
Subject: Re: [PATCH v3 7/7] eni_vdpa: add vDPA driver for Alibaba ENI
Message-ID: <20210926032701.GA32606@L-PF27918B-1352.localdomain>
Reply-To: Wu Zongyong <wuzongyong@linux.alibaba.com>
References: <cover.1631621507.git.wuzongyong@linux.alibaba.com>
 <cover.1632313398.git.wuzongyong@linux.alibaba.com>
 <296014fa3b765f2088a3183bf04e09863651a584.1632313398.git.wuzongyong@linux.alibaba.com>
 <8341d7ef-d31d-5536-864b-7d5127b7ec9f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8341d7ef-d31d-5536-864b-7d5127b7ec9f@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 26, 2021 at 10:26:47AM +0800, Jason Wang wrote:
> 
> ÔÚ 2021/9/22 ÏÂÎç8:46, Wu Zongyong Ð´µÀ:
> > +
> > +#ifdef __LITTLE_ENDIAN
> 
> 
> I think disable the device via Kconfig is better than letting user to meet
> errors like this.
> 
> (Or if the device is always using little endian, we don't even need to
> bother this).

I prefer the second suggestion since there are no use cases that the
device uses big endian
> 
> Thanks
> 
> 
> > +static int eni_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct eni_vdpa *eni_vdpa;
> > +	struct virtio_pci_legacy_device *ldev;
> > +	int ret, i;
> > +
> > +	ret = pcim_enable_device(pdev);
> > +	if (ret)
> > +		return ret;
> > +
