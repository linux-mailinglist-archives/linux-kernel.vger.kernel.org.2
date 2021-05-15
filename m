Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26EAE38162A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 07:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234329AbhEOFeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 01:34:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:46726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232792AbhEOFeT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 01:34:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D64BB613F6;
        Sat, 15 May 2021 05:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621056786;
        bh=B5DTuF90EF+MWBCeDcVtLq3OnjCaNYSF5lomIO0RGQw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MDgHYSDwbMxRyh7aLi9AleyT/VK1UINA89wMrBcREojdDcuy/nlfkMJGS36CyXrXT
         nUMExzSFgrlrIyv0ZdKoftobPMJ12vQE8uhU4+MBP2VobqXW8W4xBOjuG5wbmGzdlt
         hayrUtHQ16Z5fA/KD/DVflpAIJ61zk7QARtBL56E=
Date:   Sat, 15 May 2021 07:33:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shreyansh Chouhan <chouhan.shreyansh630@gmail.com>
Cc:     pure.logic@nexus-software.ie, johan@kernel.org, elder@kernel.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: add declare_ to declaring macros
Message-ID: <YJ9dDwKMKkifeICJ@kroah.com>
References: <20210515034116.660895-1-chouhan.shreyansh630@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210515034116.660895-1-chouhan.shreyansh630@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 15, 2021 at 09:11:16AM +0530, Shreyansh Chouhan wrote:
> Prefixed the names of all the macros that were used for declaring things
> with 'declare_'. This should help with clarifying about what these
> macros do.

Thanks, but I think I will leave the code as-is.  It's a good "test" for
people who try to modify the code without actually building it :)

greg k-h
