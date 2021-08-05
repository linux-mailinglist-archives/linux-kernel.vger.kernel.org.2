Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3A443E1345
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 12:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240491AbhHEKwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 06:52:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:45218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232312AbhHEKwm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 06:52:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E0D4F6105A;
        Thu,  5 Aug 2021 10:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628160748;
        bh=yDdn+JEA7rhe1M69nNJK+OwE84MCKMWIuH3ZOaLKkA4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JaW5mwJi3b8CSDYUTP35LKaVsnCOmEVz2D7f8/MV5s6kNbBZmkj1tJbIPxOQS5ZJP
         AuI5RHOnDPVLPD9GhHliNpQYmFO0yQhbGggT/C6x0cUCAOu+Tr1cue05duMXphI809
         A2KcX2RPR1lRqSdX31G6nOzKf8DATQJiJMbYvVXw=
Date:   Thu, 5 Aug 2021 12:52:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] staging: r8188eu: Remove wrappers for kalloc()
 and kzalloc()
Message-ID: <YQvC6YgU9Xa1hyI4@kroah.com>
References: <20210802192721.23110-1-Larry.Finger@lwfinger.net>
 <20210802192721.23110-2-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210802192721.23110-2-Larry.Finger@lwfinger.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2021 at 02:27:16PM -0500, Larry Finger wrote:
> These wrappers involve an in_interrupt() call, which is not frowned on

"which _IS_ frowned" :)

I'll take it as is...
