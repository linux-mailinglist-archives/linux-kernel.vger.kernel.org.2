Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB43352AE9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 15:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235555AbhDBNER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 09:04:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:57244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235488AbhDBNEQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 09:04:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BE58961159;
        Fri,  2 Apr 2021 13:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617368654;
        bh=HZ8xfPLTJiNl6wXC0P88v7/DGSQ6zJC/HC+Ox0RWaGA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y950T7n22AYw+gQH7I9/x8+MZ34nw7i8ZFzfwiO98OqBtDhkHkJ+bOFzH2L7rmEeq
         sb3R6Zq9iSaIHjykCHYYRblRbu/aTD43QlM5W9RzvQNnZbhhz0WAgdkixr7b7LEXYB
         zOPE7l1F9032K70a2KxUhMiqcHHgmLMhhpODQK3U=
Date:   Fri, 2 Apr 2021 15:04:12 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ivan Safonov <insafonov@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Michael Straube <straube.linux@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] staging:r8188eu: remove dummy handlers from
 OnAction()
Message-ID: <YGcWTOUl8OtAHTT4@kroah.com>
References: <20210328163323.53163-1-insafonov@gmail.com>
 <20210328163323.53163-2-insafonov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210328163323.53163-2-insafonov@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 28, 2021 at 07:33:25PM +0300, Ivan Safonov wrote:
> on_action_spct() do nothing, because rtw_get_stainfo() has no side
> effects. Other action handlers are trivial.
> 
> Signed-off-by: Ivan Safonov <insafonov@gmail.com>

Same here, wrong driver name :(
