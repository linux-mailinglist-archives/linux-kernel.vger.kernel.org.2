Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14CB635B207
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 08:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233743AbhDKGjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 02:39:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:55208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229452AbhDKGjg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 02:39:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2805A610A7;
        Sun, 11 Apr 2021 06:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618123160;
        bh=fREd7ZSaGcu2cgmLq4XKGuzplJjGYYf3PmF74aQLbsA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XWCF1dRyxH3E3t3zDQWnsLl4Sf4kaEw1fIiV2Hz7LV3EnHNz69B6FM4+pf56PEmfa
         Ehh0WaX6T8pPtdcNIbJd+gJsOqxqEHr1P9Hl1C2X0BsbVnoz8fHxJ6y7T9EZUv6hgf
         oc5MHgT46iGJ7vhNh7g0XB4IKSLa6iVTUsc2QDlE=
Date:   Sun, 11 Apr 2021 08:39:18 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH v2 0/5] staging: rtl8723bs: Change
Message-ID: <YHKZlqFy15QC9Mzz@kroah.com>
References: <20210410150008.5460-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210410150008.5460-1-fmdefrancesco@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 10, 2021 at 05:00:03PM +0200, Fabio M. De Francesco wrote:
> Remove camelcase, correct misspelled words in comments, remove an unused
> variable, change the type of a variable and its use, change comparisons
> with 'true' in controlling expressions.
> 
> Changes from v1: Fix a typo in subject of patch 1/5, add patch 5/5.

The subject line above is very odd :(

