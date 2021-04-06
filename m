Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0426355625
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 16:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240161AbhDFOMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 10:12:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:40224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236139AbhDFOMc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 10:12:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4E9E4613A7;
        Tue,  6 Apr 2021 14:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617718343;
        bh=oodJRS58Zr1qQH9SbmkMEge3e6GJAXCXrN3+8c6DR+I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iX8vd2yVg6MTs3na1+dWeT7zDgItRlbYpahwppEZNl9l7vVcdB3be9YoNkfocNXKH
         09TuLpxKe+w6dnDwOEKa/dXYXA1WFvhvG9fsrN0QnXx+7pvrkjqibp54EmNXiQ/iTN
         rIv4i8K7z96gXSL7u1J9rylVBWS2O3QgtSlrZw1Y=
Date:   Tue, 6 Apr 2021 16:12:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: Re: [PATCH v2 1/2] staging: rtl8712: Rewrite NULL comparisons
Message-ID: <YGxsRarVAblIa1l+@kroah.com>
References: <cover.1617710602.git.zhansayabagdaulet@gmail.com>
 <74471865b399584d73a18696d2008006301dfd71.1617710602.git.zhansayabagdaulet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74471865b399584d73a18696d2008006301dfd71.1617710602.git.zhansayabagdaulet@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2021 at 06:09:56PM +0600, Zhansaya Bagdauletkyzy wrote:
> Replace NULL comparisons with boolean negation to be more consistent with
> the rest of the Linux kernel code base.
> Reported by checkpatch.
> 
> Signed-off-by: Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
> ---
>  drivers/staging/rtl8712/rtl871x_recv.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

This does not apply to my tree :(
