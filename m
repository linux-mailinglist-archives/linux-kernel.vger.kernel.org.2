Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81EC830ACC3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 17:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbhBAQiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 11:38:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:59616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229763AbhBAQiH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 11:38:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 599D364EA3;
        Mon,  1 Feb 2021 16:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612197446;
        bh=MZxvcpnmVx3880fwWHX/0liaHRRZCs/cVrQn2DLd2DI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ba2xUY6lHpmJJ0dBVwyHP4RsHpWtlYDTF+N8I+2witdjooSExtICa+IQx4Fnvue+b
         NECujr6gE/EiP+MWtnwo00cDjPbiYuxATTxJJl2XGWg++fC8XYxuhlYaJKUrHlcwv7
         fgsbUzho7Ngy8AG7CXzuZn4G0T+F4CAObBTBMue0=
Date:   Mon, 1 Feb 2021 17:37:23 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     Joe Perches <joe@perches.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-kernel-mentees] Patches from the future - can checkpatch
 help?
Message-ID: <YBguQ/dENrfvtptJ@kroah.com>
References: <CABJPP5AxB8-kafFEpsMydg8eMx8bH5ooT5g7r0fKWV2T2Hjtng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABJPP5AxB8-kafFEpsMydg8eMx8bH5ooT5g7r0fKWV2T2Hjtng@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 01, 2021 at 10:04:01PM +0530, Dwaipayan Ray wrote:
> Hi,
> on linux-next,
> $ git log --pretty=format:"%h%x09%ad" | awk '$6>2021 {print $1}'
> gives:
> 4a2d78822fdf
> 12ca45fea91c
> 09f2724a786f
> 
> These are patches from the year 2085, 2037 and 2030 respectively.
> 
> Would a checkpatch rule be helpful for these or are they too
> isolated to waste runtime on?

Dates come from your email client, not the patch itself, how is
checkpatch going to catch this?

thanks,

greg k-h
