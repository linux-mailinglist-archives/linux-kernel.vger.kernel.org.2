Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC75735B208
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 08:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233979AbhDKGk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 02:40:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:55308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229452AbhDKGkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 02:40:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8F16E60FF0;
        Sun, 11 Apr 2021 06:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618123208;
        bh=yWcyVaHsSg/OYuADPlEru0Q1V+2nyXABCRz9V8mF494=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ko8ydC9qf38CY0QXM81OdYaswKjxv9vkb9T4kx4xxxlwLFqZN9zlOSHpLUmpTNg4C
         4G7eOMzlDgcsY78FZKagV9neaDinslANgJEg4vst2GvOg7FvoyXn37y17IG9xn7277
         mF/Xl0Gn8lSADfIGLPpYyteG4gMew2Xx/rvVDo34=
Date:   Sun, 11 Apr 2021 08:40:05 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mitali Borkar <mitaliborkar810@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, mitali_s@me.iitr.ac.in
Subject: Re: [PATCH v2 0/3] staging: rtl8192e: remove unnecessary parentheses
Message-ID: <YHKZxXSMCQMRYhfQ@kroah.com>
References: <cover.1618110617.git.mitaliborkar810@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1618110617.git.mitaliborkar810@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 11, 2021 at 10:03:40AM +0530, Mitali Borkar wrote:
> This patch fixes style issues
> Changes from v1:-
> [Patch 1/3]:- Removed unnecessary parentheses around boolean expressions
> [Patch 2/3]:- No changes
> [Patch 3/3]:- No changes
> 
> Mitali Borkar (3):
>   staging: rtl8192e: remove unnecessary parentheses
>   staging: rtl8192e: remove unnecessary ftrace-like logging
>   staging: rtl8192e: remove unncessary parentheses

You have two patches in this series that do different things, yet have
the same subject line (with a misspelling in one).  Please make them
unique.

thanks,

greg k-h
