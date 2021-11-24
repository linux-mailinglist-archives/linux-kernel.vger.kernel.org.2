Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 498A245B7F3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 11:01:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240698AbhKXKEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 05:04:43 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:58163 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236590AbhKXKEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 05:04:42 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id E3C7B5C00BA;
        Wed, 24 Nov 2021 05:01:32 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 24 Nov 2021 05:01:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=+fB4PZnEclA0QnnUSm3/Y6YAfLU
        7TAJrvu5O+1mTK/k=; b=Vk07cVxx+2OfuQRAW6iBh+2cKYXmo3tY3CQ3imt5brl
        l4Sl6RZ9i22IH7KU2Or056HLyz2OlskqGLAuhl9e2nuFSyzm0ceXM/ZGydC0fsh9
        wCzJnislKrFClNGReJfliS5SZpu6r6iemNg66t1yrfgTtKmboq+zo9QgWW+Z695N
        T37tQamIEosTK1ceJUTYJ1AXEv/ow2APRxSjZkj7gsZK8v1EXswHl6tlXTKSmVZc
        xSKqEgRc3mqLqoOAc0LogqM3PemR+AFe3lnT1KGkxsvvlcUu3OHFj7BqENaFnnXa
        W1FjZyJ0eRCusTITZuqCDLdZqneqD2IxSY5D5SQxHKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=+fB4PZ
        nEclA0QnnUSm3/Y6YAfLU7TAJrvu5O+1mTK/k=; b=KJ6696EGge46pCqR+9Wze6
        bC5bBM256w9fXogmCZj3BijOG40YrSCDW7pd9gVjz2hq4DG4mOjUAc3FbrEMVCUO
        KEhjwyj8nIBepHE+I8w1L+uVBg/6xhp8TYvMbGtnVFzv8zcfrnvCL0Ati7b9XYcP
        aaLA84t+NFtOy5WNKGRHd786fQ9yp0gINiePTSUBlD3A7PyO+KVBhRo9w3g+ahZR
        RhIRIL0KZ4fQFahVMAoUPZ+E9Buob7YRl1LrzkHqjtbL3aD3CCn9BmoZNauGGdaT
        kF5hkXE8PPUJ59o+W4sMcG11UQOC0TuKxsxoPlTPkG/GRRRMZIXWT9eV6w/d1Y6w
        ==
X-ME-Sender: <xms:fA2eYcDEyF2k7hmwLy8G91NUXVozu3wHwaVLYEHQv33tXcIbH7vBwg>
    <xme:fA2eYehhNngMyLFjRcJm7u2XW8emcZobKs12f2nVkZ1o8DrMAoN3QbRBN-d90kQkJ
    qSHCwVC0UGwjg>
X-ME-Received: <xmr:fA2eYfl3XnRj8clLLHIeFcSb0k4FPUgZJKIJdWrQcZB3CSYBdzPrgOQ3aGVw_gj8pHREElO7DdaR62i2URX8F9AFFlUrz09H>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrgeekgdduudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghgucfm
    jfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepveeuheejgf
    ffgfeivddukedvkedtleelleeghfeljeeiueeggeevueduudekvdetnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrd
    gtohhm
X-ME-Proxy: <xmx:fA2eYSw3cjgweKoIlkGV1ZjjUEIMNwN0DMPR8OkUUDlzRP1ipbDdSQ>
    <xmx:fA2eYRTKBuceeRWdSMOSHv_yEHmMVSYA6-NXsFJhuXdipqIKL0Bahg>
    <xmx:fA2eYdaeyJrKO-ji7tvshyxEHUmKQ0df5lMAOEg3ibmmYcHdOfkTcQ>
    <xmx:fA2eYcFQbz07I348eWTA6fxKpajRrS6AAsWmoO9l2klkc7ytoBKRiQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Nov 2021 05:01:32 -0500 (EST)
Date:   Wed, 24 Nov 2021 11:01:30 +0100
From:   Greg KH <greg@kroah.com>
To:     Zoeb Mithaiwala <zoebm@google.com>
Cc:     dan.carpenter@oracle.com, trivial@kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v3 3/3] Staging: rtl8712: Fixes a camel case variable
 name style issue
Message-ID: <YZ4Nej0yftiWh5rc@kroah.com>
References: <20211122103931.GA6514@kadam>
 <20211122170335.1468730-1-zoebm@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211122170335.1468730-1-zoebm@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2021 at 05:03:35PM +0000, Zoeb Mithaiwala wrote:
> Changes the names of variables in rtl871x_security from camel case to
> snake case to match coding style.
> 
> Signed-off-by: Zoeb Mithaiwala <zoebm@google.com>
> ---
> Changes in v3:
>   - Fixes commit messages for patch.
>   - Uses the same variable names in header file as implementation files.
> Changes in v2:
>   - Changes the variable name from nBytesInM to bytes_in_m.
>   - Removes changes to other variables in the file.

Where are patches 1/3 and 2/3 of this series?

And this looks like it does not apply to any tree at all, are you sure
you made it against the correct kernel branch?  If so, what one?

thanks,

greg k-h
