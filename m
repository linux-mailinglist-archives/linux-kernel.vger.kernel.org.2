Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F00641D306
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 08:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348215AbhI3GHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 02:07:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:46370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348054AbhI3GHn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 02:07:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 44CD76135E;
        Thu, 30 Sep 2021 06:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632981961;
        bh=65aEzRtCWNCJs0hWlwT5RktPWd0Cqar8oZ2NFQfKXo8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l+f6qDoCECa66coxo708KOOqGw58Az9BOJt0LazMi8ilBaqu3/rS9bMA42DOMAIEx
         7dRK0Pb73Gr0z6ZTqPvYnFa/Gk56rituv1AjpStXjwANYAEfB4Zu7ywCdy54GzQqVU
         PkcFVw+2pJJgvQbdsrEj6kBrRLzkyI0CvzMxSu9E=
Date:   Thu, 30 Sep 2021 08:05:57 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jim Cromie <jim.cromie@gmail.com>
Cc:     jbaron@akamai.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] dyndbg updates for 5.15-rcX
Message-ID: <YVVTxZDkGUk7dGLp@kroah.com>
References: <20210929183735.6630-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210929183735.6630-1-jim.cromie@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 12:37:29PM -0600, Jim Cromie wrote:
> Hi Jason, Greg,
> 
> Heres a set of "maintenance" patches distilled out of other work.  Its
> almost all tweaks to verbose output, except for 1st, which changes a
> strcmp to == because its true, and useful going forward.
> 
> Jim Cromie (6):
>   dyndbg: recode for stronger precondition
>   dyndbg: show module in vpr-info in dd-exec-queries
>   dyndbg: rationalize verbosity
>   dyndbg: use alt-quotes in vpr-infos, not those user might use
>   dyndbg: vpr-info on remove-module complete, not starting
>   dyndbg: no vpr-info on empty queries
> 
>  .../admin-guide/dynamic-debug-howto.rst       |  2 +-
>  lib/dynamic_debug.c                           | 47 ++++++++++---------
>  2 files changed, 26 insertions(+), 23 deletions(-)

Are these real bug fixes that have to get into 5.15-final?  They seem
like 5.16-rc1 patches instead.

thanks,

gre gk-h
