Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4D323FEE70
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 15:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344953AbhIBNL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 09:11:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:55032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244365AbhIBNL5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 09:11:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6187060FDC;
        Thu,  2 Sep 2021 13:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630588258;
        bh=adA+jwZq7aqHTm2b2+AsjCLQWY9GYqG8UkiSZIh/6mE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jcaYOT75OBj7MXM0nCLn8W+X7XSJ7kMWhNNQoSUO4/SV4bfl/gteCdC8257rL4tG0
         B+v78Ij+8frK/aXYQYs5HSSRYCUHRr+WzwkJBkbW2qEF51MXkuNcghwuihcSCUirPr
         stRdvzMvSzkTKC30nCxck4ewa8oxYhQMP5DmWucj8esbK2I/fTc4a5ts/rXb/pu7x+
         mJvsG5MO0kYgxNOfzzDAlFZ5gdWzCKGUzIHR84CHkM2u3lVgHGlGeCHD3RTNBIKITw
         VTGNBO2qdlfAosnOYK9GHNt02BObrk1agz1a9FnX1HbReGvC/hGWkChClgSvO/j+c2
         YGDBmjc/mgRgg==
Date:   Thu, 2 Sep 2021 15:10:53 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh@kernel.org>, linuxarm@huawei.com,
        mauro.chehab@huawei.com, John Stultz <john.stultz@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] misc: hisi_hikey_usb: change the DT schema
Message-ID: <20210902151053.7ddfbe3a@coco.lan>
In-Reply-To: <YTC4LPDem9uKXyMd@kroah.com>
References: <cover.1630581434.git.mchehab+huawei@kernel.org>
        <d990e75f28c443c0c5a5fc857b87acc4be3f9464.1630581434.git.mchehab+huawei@kernel.org>
        <YTC4LPDem9uKXyMd@kroah.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 2 Sep 2021 13:40:28 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> escreveu:

> On Thu, Sep 02, 2021 at 01:28:35PM +0200, Mauro Carvalho Chehab wrote:
> > As there's no upstream DT bindings for this driver, let's
> > update its DT schema, while it is not too late.  
> 
> So this is for 5.15-final?

It can either be for 5.15 or 5.16, as there aren't any compatible
under arch/ which uses the DT schema there. All patches adding
such compatible are on this series. So, whatever version this
is applied should be OK.

Thanks,
Mauro
