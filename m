Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E71363A24B4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 08:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbhFJGuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 02:50:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:45304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229634AbhFJGuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 02:50:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B61D8613D9;
        Thu, 10 Jun 2021 06:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623307690;
        bh=jFG3A6Xp6otM23+Y9QF0m744OnTv47EUweGgFifrNQk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aj28qWZs74tuqbFFr0kcxw12OiWtmK822qwFNqsygLPonNXMZCEBt8buocidz57dN
         W6nPfb45FgmC6CoLgpxDdeL9n3LQSm2EmHvzkW6HlAjFBxzFVYAT7+NFHegd+ocf5j
         5HXsPth5u5gjborC58MrBIIjrVxLrlBQMi1L9iI8=
Date:   Thu, 10 Jun 2021 08:47:40 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Joel Stanley <joel@jms.id.au>
Cc:     linux-fsi@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Jeffery <andrewrjeffery@gmail.com>
Subject: Re: [GIT PULL] fsi changes for v5.14
Message-ID: <YMG1jKIcjKuclyRR@kroah.com>
References: <CACPK8XencP__O6v28e+v0PD8wOTpfRRu_oyV-rin0tA64kdP7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACPK8XencP__O6v28e+v0PD8wOTpfRRu_oyV-rin0tA64kdP7A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2021 at 05:01:55AM +0000, Joel Stanley wrote:
> Hello Greg,
> 
> Here are some FSI changes that I'd like you to take through the driver
> tree for v5.14.
> 
> The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:
> 
>   Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/joel/fsi.git tags/fsi-for-v5.14

Pulled and pushed out, thanks.

greg k-h
