Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCE7930EDF7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 09:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234752AbhBDIFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 03:05:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:55586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234841AbhBDIEe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 03:04:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 80F7F64E31;
        Thu,  4 Feb 2021 08:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612425833;
        bh=l9ZMtxaWdlJ1HbbmtjUwxdoQZJ9SJ+NLgrPaOz9k7aY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ezlazHLvCAOyaozx0y2isxj4ErAbPbIVApegzjf/SLS9X5vRKNabzavRgeLvnNWgh
         tjH6TMNmy3m6HcvF1L+nFvh80zgOaYfyduYGxx2XtTyebBIGVFmv63oXtI2rKB7xo8
         l7iCJUCrGj+8J7XfDsBEifXKI9/5Fvdv/+gOZIEZ1cqQaaPKff7VnmNTc0otT5Nbsr
         wnu30TQUHoY//+wfuUNPYuKpNDadKOmHpqCw6atnNirzZxnUjmDIflN3bH2sVDaCXT
         9dX8/4sJJ8tOd7slEAd8A6RU7p/zF5itofJ2jZ2r3C6nC+9jKkn18+87rNkVIRPJlm
         53e423qQDwHiQ==
Date:   Thu, 4 Feb 2021 13:33:49 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Alex Dewar <alex.dewar90@gmail.com>,
        David Gow <davidgow@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Yu Chen <chenyu56@huawei.com>, devel@driverdev.osuosl.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 10/14] phy: phy-hi3670-usb3: move driver from staging
 into phy
Message-ID: <20210204080349.GL3079@vkoul-mobl.Dlink>
References: <cover.1611932194.git.mchehab+huawei@kernel.org>
 <810f286cade454acda418b9e5f39bb3a595e871a.1611932194.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <810f286cade454acda418b9e5f39bb3a595e871a.1611932194.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-01-21, 16:03, Mauro Carvalho Chehab wrote:
> The phy USB3 driver for Hisilicon 970 (hi3670) is ready
> for mainstream. Mode it from staging into the main driver's
> phy/ directory.

Acked-By: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
