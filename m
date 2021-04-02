Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD827352AE8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 15:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235485AbhDBNEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 09:04:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:57100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234628AbhDBNEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 09:04:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F18FB61152;
        Fri,  2 Apr 2021 13:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617368645;
        bh=uTN7GP5Y8DqpShutxxOZR+o6yoQl//v/6cvvpP11nVQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FuV6IrYg5owX37hvdQ3GDhli6J7grV8XxceW0qLbZNTUg+/u8NZIwSSwacl3qPLQ3
         zLUR9Zs1xeopBv9IW9LGAV8L74VKugKQWoIxBFpG4pqPxqye/g2CSnZJlxn0twTMnk
         DD/pKdTaCPk6nnvb7gGmON8Vqfo2zEq9DTdjktOI=
Date:   Fri, 2 Apr 2021 15:04:02 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ivan Safonov <insafonov@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Michael Straube <straube.linux@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] staging:r8188eu: refactor OnAction(): use switch
 instead table lookup
Message-ID: <YGcWQrFMWhx6Zb8T@kroah.com>
References: <20210328163323.53163-1-insafonov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210328163323.53163-1-insafonov@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 28, 2021 at 07:33:23PM +0300, Ivan Safonov wrote:
> The switch is easier to read and refactor.

Your subject line is incorrect :(

