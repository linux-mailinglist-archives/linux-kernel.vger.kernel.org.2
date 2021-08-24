Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 019133F5F83
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 15:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237616AbhHXNwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 09:52:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:59244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234881AbhHXNwg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 09:52:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 849B7610CD;
        Tue, 24 Aug 2021 13:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629813112;
        bh=FxuPLFnt5PlfufJjWt95qillUmpi2UISlCCpPdxM6+8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YL+j1ukjQhZjDtf24siUcnsA0AiV+6oT8KJwipBBNCl1HypoBXHq95VvPtqnebt0e
         JhriHt6UIoxEicreKeXfpS0zjBIO7d5pBNy5eT+CH3Bo7rhOrT2XRofqI7ra0k9zmf
         9xUht8tiOy+rBFXz/cx9jMV+H5ZX9FMwy1lwM13c=
Date:   Tue, 24 Aug 2021 15:43:54 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     haver@linux.ibm.com, arnd@arndb.de, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] misc: genwqe: switch from 'pci_' to 'dma_' API
Message-ID: <YST3mkjsoGyM73RY@kroah.com>
References: <a9057c3fff852a043298a2091c7fc3c371306da4.1629660362.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9057c3fff852a043298a2091c7fc3c371306da4.1629660362.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 22, 2021 at 09:27:06PM +0200, Christophe JAILLET wrote:
> The wrappers in include/linux/pci-dma-compat.h should go away.
> 
> The patch has been generated with the coccinelle script below.

Again, explain why this is needed.
