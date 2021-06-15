Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B82023A823A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 16:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbhFOOQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 10:16:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:42780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230286AbhFOOPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 10:15:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CCF13613CC;
        Tue, 15 Jun 2021 14:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623766415;
        bh=f7pdLGtG6rawV3SR0vHJmka3gIR17V/4bjngUYmj/Xs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oUoolvRHdgoDuBivQuH9PBg3Cmxy0hByOPfA8evAU2LkdDt89lFq2U5vJ/cBsNAPR
         Q5yx/Pi3JBiGJWiGOkdBvdjWMdLWQI+7dhpolXF1xIq7ie3/TRe+yDDmE8smwOU7vW
         5cTFDX75PbL3WtLxqxvfhlzmSHmB46keSN62av6k=
Date:   Tue, 15 Jun 2021 16:13:32 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alex Nemirovsky <Alex.Nemirovsky@cortina-access.com>
Cc:     Jason Li <jason.li@cortina-access.com>,
        Rob Herring <robh+dt@kernel.org>,
        Rob Herring <robh@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/3] dt-bindings: serial: Convert Cortina-Access UART
 to json-schema
Message-ID: <YMi1jOL6y+eUK3Df@kroah.com>
References: <20210509184519.15816-1-alex.nemirovsky@cortina-access.com>
 <20210509184519.15816-2-alex.nemirovsky@cortina-access.com>
 <YMiUpK/+PjsoCU1W@kroah.com>
 <CFD14D63-4537-4A91-861C-71B74E2CFAE6@cortina-access.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CFD14D63-4537-4A91-861C-71B74E2CFAE6@cortina-access.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2021 at 01:36:39PM +0000, Alex Nemirovsky wrote:
> MAINTAINERS modification was made in the initial version 1.  We made no changes to it since then,
> thus not sure what we could at to  Changelog which would add value or clarity for others
> from the v1.
> 
> > On Jun 15, 2021, at 4:53 AM, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > 
> > On Sun, May 09, 2021 at 11:45:17AM -0700, Alex Nemirovsky wrote:
> >> From: Jason Li <jason.li@cortina-access.com>
> >> 
> >> Convert the Cortina-Access UART binding to DT schema format.
> >> 
> >> Signed-off-by: Jason Li <jason.li@cortina-access.com>
> >> ---
> >> .../serial/cortina-access,serial.yaml         | 46 +++++++++++++++++++
> >> .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
> >> MAINTAINERS                                   |  6 +++
> > 
> > You are also adding a MAINTAINERS entry here, which is not listed in the
> > changelog text, so I couldn't take it anyway :(

Add the maintainers entry in the first patch, with the driver please.
