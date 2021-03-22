Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73A12344A9B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 17:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbhCVQH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 12:07:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:54450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232097AbhCVQG5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 12:06:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 69269619B4;
        Mon, 22 Mar 2021 16:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616429216;
        bh=lv+hnh9RxxDgrwOwcye99nPeGlcWjoMWr4QPccdIbGc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VY2AAfPkU1A5/ez5/A8DVda1Y/cxV5rZsU25AlQvEyOSszLIzKLUldUeOKqDKnf98
         8Gyd9XtYWR2//1lPn6i9Ny7QW+H0jJFs93EeyBxSmNZ+266ITlFOoXzeeZDMkEhSFJ
         fi4IYsaqMvN6NeLTe8h0HjWLGtRdtvYtG19rdNrY=
Date:   Mon, 22 Mar 2021 17:06:35 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     joe@perches.com, apw@canonical.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/11] staging: rtl8723bs: remove unnecessary extern in
 os_dep/sdio_intf.c
Message-ID: <YFjAi/Swxepg20q3@kroah.com>
References: <cover.1616422773.git.fabioaiuto83@gmail.com>
 <be21175bd3ce666110e507a3e577e1a053700a9c.1616422773.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be21175bd3ce666110e507a3e577e1a053700a9c.1616422773.git.fabioaiuto83@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 03:31:49PM +0100, Fabio Aiuto wrote:
> remove unnecessary extern.
> 
> The function is defined static in os_dep/os_intfs.c and used only once
> in the same file
> 
> remove also a blank line

That needs to go to a separate patch :(

