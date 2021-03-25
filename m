Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E63D34994E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 19:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbhCYSPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 14:15:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:56426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230210AbhCYSPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 14:15:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F0462619C7;
        Thu, 25 Mar 2021 18:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616696107;
        bh=SRXJYhCLMi9lpIROJ6aYlDKwgzjwWyya99ffnjSA1+M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lQBcwuoct09JnABqoG7WQcirlu2KKAfH9h0rjKcMxA+dZLzcXb3YadrmLA7lCnNP6
         AjmKVvJNr3ZI7up62pJqPDu1ngnLcSMdOwOSBYD6YjXzFMQS0c7KHOnA31uB5xN4i6
         PYbzJrHSmuqJTEIypuH800gJ91XAU3Hlhkh5I/qAvUYTxNMxsUtFXUA+ZHd3R78RuY
         aCA1ZM27G7ELnB3uAJM9HQP8LRVJ/PVIA5Rz8jEBVrmjuxmwYgwaBfuAUNx0lI56sH
         ivNjDrfKtuFKdFt+R3J1wdhqmPq6YRZnTESc7eTDCe51mn7IRuY0IJd7G2kPnC6Bnd
         oW2vDRxzzirTA==
Date:   Thu, 25 Mar 2021 19:15:02 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v5 4/7] mfd: hi6421-spmi-pmic: move driver from staging
Message-ID: <20210325191502.504f5cef@coco.lan>
In-Reply-To: <20210325163641.GV2916463@dell>
References: <cover.1616686958.git.mchehab+huawei@kernel.org>
        <de3603a366c172923771d3f01aa83b70cbba2199.1616686958.git.mchehab+huawei@kernel.org>
        <20210325163641.GV2916463@dell>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 25 Mar 2021 16:36:41 +0000
Lee Jones <lee.jones@linaro.org> escreveu:

> On Thu, 25 Mar 2021, Mauro Carvalho Chehab wrote:
> 
> > This driver is ready for mainstream. So, move it out of staging.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  .../mfd}/hisilicon,hi6421-spmi-pmic.yaml       |  0
> >  MAINTAINERS                                    |  7 +++++++
> >  drivers/mfd/Kconfig                            | 16 ++++++++++++++++
> >  drivers/mfd/Makefile                           |  1 +
> >  .../hikey9xx => mfd}/hi6421-spmi-pmic.c        |  0
> >  drivers/staging/hikey9xx/Kconfig               | 18 ------------------
> >  drivers/staging/hikey9xx/Makefile              |  1 -
> >  7 files changed, 24 insertions(+), 19 deletions(-)
> >  rename {drivers/staging/hikey9xx => Documentation/devicetree/bindings/mfd}/hisilicon,hi6421-spmi-pmic.yaml (100%)
> >  rename drivers/{staging/hikey9xx => mfd}/hi6421-spmi-pmic.c (100%)  
> 
> Could you please resend this with out using the -M flag.
> 
> I can't review a driver I can't see.

Sure! Resent.

Regards,
Mauro
