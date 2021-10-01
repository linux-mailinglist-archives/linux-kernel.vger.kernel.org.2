Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C146741F23D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 18:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355115AbhJAQjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 12:39:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:33100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354635AbhJAQjL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 12:39:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0FD7E6109E;
        Fri,  1 Oct 2021 16:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633106247;
        bh=jrl2YhyHoUdaRTF3s8q4PJKPiBFPytXlEA9Ow6uY5ZY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SP9jYkGh8LJ08CdKPRYmKvO+U83FSCxVOQeT/wziT6XuSfam748q1B6Va9NhwadUq
         51olSBOlhS0v3VMUSWy070PGh4jZZcaZW2ehPF/wGsTOzotKqK72rKUxaY01mAMyfa
         8CEG+hXx2cabcyeAsHLguY3Wau2ZWwxB986XMOdv4sttRx26GuqHjXlB76Qp+C4rux
         tPQpyc7r32giGZDO6dZ33KbVP4qlA7icTwB0PLs3eneEgsT1hFVbjPxj0ikyrHjpPj
         pn39QBJZXRUz2zv88c6nMW2ngd3UOpK5e2UANhHS6Ni/NZlHKW+4ff5yoAP9x+/zzF
         RKnc/+/p9Z/JA==
Date:   Fri, 1 Oct 2021 09:37:25 -0700
From:   Mike Rapoport <rppt@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] memblock: Neaten logging
Message-ID: <YVc5RYT+MovmWiiI@kernel.org>
References: <623750dd31aa3fe5e45c416be98ab37707e2c45d.camel@perches.com>
 <YVYoVNFBMER4bjrT@kernel.org>
 <6573ccd25ce80f5e28ed35e4c88c898b0f994fbc.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6573ccd25ce80f5e28ed35e4c88c898b0f994fbc.camel@perches.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 06:27:15PM -0700, Joe Perches wrote:
> On Thu, 2021-09-30 at 14:12 -0700, Mike Rapoport wrote:
> > Hi Joe,
> > 
> > On Wed, Sep 29, 2021 at 09:43:14PM -0700, Joe Perches wrote:
> > > Use more typical kernel logging styles.
> > > 
> > > o Add and use #define pr_fmt KBUILD_MODNAME ": " fmt
> > 
> > I don't see it as an improvement. On the contrary, the output becomes
> > somewhat tautological:
> 
> And rather easier to grep as the prefix is constant.

memblock_ is perfectly greppable
 
-- 
Sincerely yours,
Mike.
