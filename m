Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD043305DD4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 15:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233783AbhA0OFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 09:05:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:35546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232140AbhA0ODc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 09:03:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 782CF20799;
        Wed, 27 Jan 2021 14:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611756172;
        bh=ZUFHXy1yL7HHCzaVO1elnvtzcSU5af6MJN5+qibd2eU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HLh1CpehNUPvHw423O/IJU/8FX08Yfa4hDIkf0rQmGg4t0sAqba0tfTexXHtRnncS
         evu0jL6g7hJt6xacLvSzUK6GjMFzUfoTTL4AhrXeSXOr88w7n9SpMkXS5UzLONmago
         83HkrCxMa7OnMJ88gziCWAZa+Reknu9/GZo1Wjks=
Date:   Wed, 27 Jan 2021 15:02:49 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ioana Ciornei <ciorneiioana@gmail.com>
Cc:     linux-kernel@vger.kernel.org, laurentiu.tudor@nxp.com,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: Re: [PATCH 0/5] bus: fsl-mc: add userspace support
Message-ID: <YBFyiQJLklTuQH7z@kroah.com>
References: <20210114170752.2927915-1-ciorneiioana@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210114170752.2927915-1-ciorneiioana@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 07:07:47PM +0200, Ioana Ciornei wrote:
> From: Ioana Ciornei <ioana.ciornei@nxp.com>
> 
> This patch set adds userspace support in the fsl-mc bus along with a
> rescan attribute to the root DPRC container. An earlier discussion on
> this functionality can be found at the link below. I didn't continue
> with the versioning scheme since quite some time has passed since the
> last discussion.
> https://lkml.org/lkml/2018/11/20/1162
> 
> The FSL_MC_SEND_MC_COMMAND ioctl acts as a direct passthrough to the
> Management Complex (or MC) by passing fixed-length command/response
> pairs. Keeping in mind that the MC manages DPAA2 hardware resources and
> provides and object-based abstraction for sofware drivers, the proposed
> ioctl interface enables userspace tools to do the following: 
>  - Get layout information about the available resources abstracted and
>    exported by the Management Complex firmware. This is especially
>    useful to generate a complete description of the current hardware
>    resource partitioning.
>  - Manage DPAA2 objects lifecycle (create, destroy) and establish
>    connection between different components as needed.
> 
> The ioctl interface is intended for dynamic usecases where DPAA2 objects
> need to be created on demand or destroyed so that the underlying
> hardware resources can be further repurposed. In static usecases,
> depending on the requirements, a firmware configuration file can be used
> to describe the needed DPAA2 objects, their attributes or any link
> between them.
> 
> Each command received through the ioctl interface is first checked
> against a list of accepted MC commands. Also, commands which would alter
> the hardware resource management require CAP_NET_ADMIN.  The command is
> also check so that it does not contain garbage beyond the maximum size
> expected for that command id.

I need an ack from the maintainers here before I can take this series.

thanks,

greg k-h
