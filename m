Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC863808F3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 13:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbhENLym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 07:54:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:34398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232376AbhENLyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 07:54:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4424F61205;
        Fri, 14 May 2021 11:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620993210;
        bh=XXtd9ucst4S4VMjxuRSCRk5PjJQVGPKEKNdZzvDX2Ko=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1zE+si6k4D/4lZ+KK73lD4fNHZjgSuuMLZF8ZyFfkjbNneIEcJyAze6FxwyVkk9Pf
         emsG77CzVUu5DidlFJMlak9k7aVr1p18SmoTEIEihaYYAuI08x7Qxd6frj9DCCnwcD
         Yv7+Kq4WEljjHtL7YjNpMro9O8Fpj1Zi4zhNwCIc=
Date:   Fri, 14 May 2021 13:53:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Moriis Ku <saumah@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 8250:Add SUNIX SDC series uart driver
Message-ID: <YJ5kthe4huYQn+d1@kroah.com>
References: <20210514114546.5330-1-saumah@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210514114546.5330-1-saumah@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2021 at 07:45:46PM +0800, Moriis Ku wrote:
> From: Morris Ku <saumah@gmail.com>
> 
> Add SUNIX SDC series uart driver

That is not what this commit does, sorry.

