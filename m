Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6BE3F9C60
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 18:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234662AbhH0Q0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 12:26:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:33912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229800AbhH0Q0j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 12:26:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 84A5B60560;
        Fri, 27 Aug 2021 16:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630081550;
        bh=Ao7M5CDIGfgWT4AvVe5ib8Z005rBiV82V/A70GFEIKQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NRBzDbnlpz0iU/UVn58DJd39gtDdv+/ODQ5OS6FYsjEkSbzNcyRz42bNBHifhLpEu
         RpZN4bYwYzsQAhqPYJmzhYfihUnqjc1Isc1i6r3zBpB8dkL7AyKkXk0e8j+ISAGcqX
         4KSix7/BrEHc0ucoFspMshpnr2ebgZYpUCEWFwOo=
Date:   Fri, 27 Aug 2021 18:25:43 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bryan Brattlof <hello@bryanbrattlof.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] staging: rtl8723bs: remove unused functions
Message-ID: <YSkSBy4iu3byyza/@kroah.com>
References: <cover.1630080164.git.hello@bryanbrattlof.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1630080164.git.hello@bryanbrattlof.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2021 at 04:12:56PM +0000, Bryan Brattlof wrote:
> Changes in v3:
>  - Fix issue causing some emails to drop their In-Reply-To: header.
> 
>  (For the curious: NullMailer & my email provider where conspiring)

Did not quite work, see:
	https://lore.kernel.org/r/cover.1630080164.git.hello@bryanbrattlof.com
as proof that only this message, and 1/5 were linked together.

The other 4 were out on their own :(

Also, there was no "v3" in the subject line as the documentation asks
for :(

v4 please?

thanks,

greg k-h
