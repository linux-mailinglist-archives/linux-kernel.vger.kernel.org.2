Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B27833451B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 18:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbhCJR2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 12:28:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:48920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233145AbhCJR1z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 12:27:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F412564F71;
        Wed, 10 Mar 2021 17:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1615397275;
        bh=dgig/DPPgbhGx7R0guWMHNJWZOxMdyC6PzLk9uYQh54=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qXfCqlAooJcLZQ/UZcaZaoZ9Dt4StePC8jh4asY+Lcp2wdhXRM1mqHuW8136D2gp8
         2U4eP5L1DxiEsJRIssL8cJF+f3ZGl+jd3k68+9qJqc65N60DoGK9C5maPPJEP9VbrJ
         m8SeJ1nucLLFsw9vkhiCTQox3qJ3o2ATtT+pdRM8=
Date:   Wed, 10 Mar 2021 18:27:53 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Shuo Liu <shuo.a.liu@intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] virt: acrn: Fix document of acrn_msi_inject()
Message-ID: <YEkBme4o4Q9URaJe@kroah.com>
References: <20210310160538.26227-1-shuo.a.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210310160538.26227-1-shuo.a.liu@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 12:05:38AM +0800, Shuo Liu wrote:
> This fixes below build warning.
> 
> ../drivers/virt/acrn/vm.c:105: warning: expecting prototype for
> acrn_inject_msi(). Prototype was for acrn_msi_inject() instead

That's not a "normal" build warning is it?  the compiler isn't spitting
it out...

Sorry to be a pain, but please be specific as to what is causing this to
show up...

thanks,

greg k-h
