Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44E1F3A5850
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 14:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbhFMMgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 08:36:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:46378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231733AbhFMMgf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 08:36:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7B9E96120E;
        Sun, 13 Jun 2021 12:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623587660;
        bh=Uo6KONhUM11rl9mF6xj85ye4nwHE9oZO9QBwRDhb8p4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u9JyDikhxDstULDFDS0ugvs71ttab4Nqo2saxD5cWbYp65d48E5YVyZ2vr1w3m2T3
         yEoic68Qzhb9u2+8hhI4YoPs5SOkkmXmHBhI5vbJx0aR24TZDVdoCfJbqNevWyvu7Y
         eM6oX2KiYQErdnlSgjs2JuLL0FfHuBM9VRPN4210=
Date:   Sun, 13 Jun 2021 14:34:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jhih-Ming Huang <fbihjmeric@gmail.com>
Cc:     fabioaiuto83@gmail.com, ross.schm.dev@gmail.com,
        maqianga@uniontech.com, marcocesati@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rtw_security: fix cast to restricted __le32
Message-ID: <YMX7SRSPgvMA/Pw1@kroah.com>
References: <20210613122858.1433252-1-fbihjmeric@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210613122858.1433252-1-fbihjmeric@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 13, 2021 at 08:28:58PM +0800, Jhih-Ming Huang wrote:
> This patch fixes the sparse warning of fix cast to restricted __le32.
> 
> Last month, there was a change for replacing private CRC-32 routines with
> in-kernel ones.
> In that patch, we replaced getcrc32 with crc32_le in calling le32_to_cpu.
> le32_to_cpu accepts __le32 type as arg, but crc32_le returns unsigned int.
> That how it introduced the sparse warning.

As crc32_le returns a u32 which is in native-endian format, how can you
cast it to le32?  Why do you cast it to le32?  Isn't that going to be
incorrect for big endian systems?

thanks,

greg k-h
