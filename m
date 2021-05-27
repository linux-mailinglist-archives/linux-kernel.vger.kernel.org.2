Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6D38392BA1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 12:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236115AbhE0KWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 06:22:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:50854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236109AbhE0KWq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 06:22:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 87278613B5;
        Thu, 27 May 2021 10:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1622110872;
        bh=vgyzIt6CtN9vLG6Di+ovSQQxvs1QgUK+S4mPaEabHmA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=11+uRWoCllq7Babz/VF18cY/kKDxCKFgkGSjDh68G44Jb6/e3LUJZ5WFljAf0LdK7
         Vg1Hv4/n6craKsTv+bNZY8Xz8cbt4XMnZuvJ4y3i4+VMx1sCfLqv31O9Wq34WhTPul
         SxuvcYKOrykqNZMF7Fz1Q7Xf1MbxFy2xd6Q6VKKc=
Date:   Thu, 27 May 2021 12:21:09 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kyle Tso <kyletso@google.com>
Cc:     heikki.krogerus@linux.intel.com, robh+dt@kernel.org,
        badhri@google.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: connector: Replace BIT macro with generic
 bit ops
Message-ID: <YK9ylVgwXJB4oNfk@kroah.com>
References: <20210527101345.569725-1-kyletso@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210527101345.569725-1-kyletso@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 06:13:45PM +0800, Kyle Tso wrote:
> BIT macro is not supported in dt-bindings. Replace it with generic bit
> operations.

Why isn't the BIT macro supported there?  How are we going to "remember"
that I should not take patches that use this #define in that location?

thanks,

greg k-h
