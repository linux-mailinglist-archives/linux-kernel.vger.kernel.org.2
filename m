Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8C9431698B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 15:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbhBJO5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 09:57:42 -0500
Received: from mail.baikalelectronics.com ([87.245.175.226]:34458 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbhBJO5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 09:57:33 -0500
Date:   Wed, 10 Feb 2021 17:56:40 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 09/10] usb: dwc3: qcom: Detect DWC3 DT-nodes with
 "usb"-prefixed names
Message-ID: <20210210145640.xhvcnarq3xoeeesu@mobilestation>
References: <20201205155621.3045-1-Sergey.Semin@baikalelectronics.ru>
 <20201205155621.3045-10-Sergey.Semin@baikalelectronics.ru>
 <YBnZ8O+zI/dzrjDQ@builder.lan>
 <YBpnpj+0KHM1Q8l8@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YBpnpj+0KHM1Q8l8@kroah.com>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 03, 2021 at 10:06:46AM +0100, Greg Kroah-Hartman wrote:
> On Tue, Feb 02, 2021 at 05:02:08PM -0600, Bjorn Andersson wrote:
> > On Sat 05 Dec 09:56 CST 2020, Serge Semin wrote:
> > 
> > > In accordance with the USB HCD/DRD schema all the USB controllers are
> > > supposed to have DT-nodes named with prefix "^usb(@.*)?".  Since the
> > > existing DT-nodes will be renamed in a subsequent patch let's first make
> > > sure the DWC3 Qualcomm driver supports them and second falls back to the
> > > deprecated naming so not to fail on the legacy DTS-files passed to the
> > > newer kernels.
> > > 
> > 
> > Felipe, will you merge this, so that I can merge the dts patch depending
> > on this into the Qualcomm DT tree?
> 
> Patches this old are long-gone out of our queues.  If it needs to be
> applied to a linux-usb tree, please resend.

Greg, Bjorn,
I've revised and resent the series. Please find the recently posted
patchset:
Link: https://lore.kernel.org/lkml/20210208135154.6645-1-Sergey.Semin@baikalelectronics.ru/

Alas I've forgotten to Cc the linux-usb mailing list. Should I resend
the series one more time?

-Sergey

> 
> thanks,
> 
> greg k-h
