Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42D253D0151
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 20:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbhGTRcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 13:32:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:41326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229638AbhGTRbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 13:31:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A280F610F7;
        Tue, 20 Jul 2021 18:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626804699;
        bh=rIvcPnlk8F/v3noffv3nLg5nIBn+iiWimm3NpnDG1fU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BsOmLpLNkcg+5IcUXmRopcIJAHJ0Na5eiECJ2oyRTOp02vXF+TtI2sRDdp0HaPjVZ
         6rXKYtkIgsSLenrRqiAzJGIxUrgUjxnr6I6dtAhfmuu4d1vAADufNxYBkf3MSvT7wo
         I14Ao87YvNyrjDlWba/lnHEaPyImDNA1zWwdnvBI=
Date:   Tue, 20 Jul 2021 20:11:36 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vishnu Dasa <vdasa@vmware.com>
Cc:     Jorgen Hansen <jhansen@vmware.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Pv-drivers <Pv-drivers@vmware.com>
Subject: Re: [PATCH] MAINTAINERS: Update for VMCI driver
Message-ID: <YPcR2BHqTEamU3dU@kroah.com>
References: <1626776941-9163-1-git-send-email-jhansen@vmware.com>
 <YPan14jucU9/u6JL@kroah.com>
 <0DE37084-185C-4144-AF9E-22EC044B0CB5@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0DE37084-185C-4144-AF9E-22EC044B0CB5@vmware.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 20, 2021 at 06:04:15PM +0000, Vishnu Dasa wrote:
> 
> On Jul 20, 2021, at 3:39 AM, Greg KH <gregkh@linuxfoundation.org<mailto:gregkh@linuxfoundation.org>> wrote:
> 
> Also I would need an ack from Vishnu.
> 
> Acked-by: Vishnu Dasa <vdasa@vmware.com<mailto:dasa@vmware.com>>

A maintainer that sends html email isn't going to work very well :(

Please fix.

greg k-h
