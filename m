Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19CE73E1363
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 13:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240629AbhHELCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 07:02:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:54856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240551AbhHELC0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 07:02:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 44A64610CC;
        Thu,  5 Aug 2021 11:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628161331;
        bh=ZTRYMBgLQMHnfEDLljdtt2hgoITgQbD7wf+/G6oaRGU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IOwkk/VkD9lBsvOk4zMCY/YQxekSrFQlri6wLVo1cLZeF0Uk7VetEt69ZFOVQ0y1A
         QgzrbDOGXv0P6F+FC/MX3FQaLJKu8y7kZwBsQm5cB11Wa15d3nMUBxSfe096QxLtpo
         DpPu/bURVutRomG6lz68bvHpJD7kocw3cO54s4/0=
Date:   Thu, 5 Aug 2021 13:02:09 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] staging: r8188eu: remove RT_TRACE and DBG_88E prints
 from xmit_linux.c
Message-ID: <YQvFMccB/Gl+AGOf@kroah.com>
References: <20210803201511.29000-1-martin@kaiser.cx>
 <20210803201511.29000-6-martin@kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210803201511.29000-6-martin@kaiser.cx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03, 2021 at 10:15:11PM +0200, Martin Kaiser wrote:
> We should use the standard mechanism for debug prints. Remove the prints
> that use driver-specific macros.

It is ok to remove the RT_TRACE macros, but you are removing the other
debugging calls and are not replacing them with anything.

Are you sure that is ok?  Why not use the proper debugging calls instead
of just deleting them?

thanks,

greg k-h
