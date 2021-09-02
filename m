Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B25AD3FED14
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 13:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245183AbhIBLlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 07:41:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:45600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234250AbhIBLlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 07:41:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9C0A061053;
        Thu,  2 Sep 2021 11:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630582831;
        bh=nVxYErBRbxQEWLPVEYoMzcscZ1LheKMaHL360GFaauA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lSMviRV9AFBohIflRZ9gvFrka6NLbbs0bKylLoAKtemEULOkKvEss67f4NnaYDlwc
         7lR92HwAaJ0+LObyAUNxmUbN4hcANwvG+A3l5AzbY+n26jvNw9s12+vrFmsUvZZNze
         HuwIBkHZOV6IuUJfBPWDV6h/p0p50/iX2tnP2D8Q=
Date:   Thu, 2 Sep 2021 13:40:28 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, linuxarm@huawei.com,
        mauro.chehab@huawei.com, John Stultz <john.stultz@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] misc: hisi_hikey_usb: change the DT schema
Message-ID: <YTC4LPDem9uKXyMd@kroah.com>
References: <cover.1630581434.git.mchehab+huawei@kernel.org>
 <d990e75f28c443c0c5a5fc857b87acc4be3f9464.1630581434.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d990e75f28c443c0c5a5fc857b87acc4be3f9464.1630581434.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2021 at 01:28:35PM +0200, Mauro Carvalho Chehab wrote:
> As there's no upstream DT bindings for this driver, let's
> update its DT schema, while it is not too late.

So this is for 5.15-final?

thanks,

greg k-h
