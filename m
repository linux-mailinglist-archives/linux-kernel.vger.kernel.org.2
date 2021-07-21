Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA663D0CCF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 13:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238768AbhGUJ4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 05:56:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:54962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238293AbhGUJny (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 05:43:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4F0016044F;
        Wed, 21 Jul 2021 10:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626863067;
        bh=qXL2BQ9s1xaPrPK4raWZPJOE10/JXu3XKZ4LIng7iCk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0RyOeoO9sEjgVwDWbOxvGh+oDsIvf7kfuFigyKshmgwbeQNb9yApc52bJp5kOBzLt
         GLYIr5eDjmTRLdXhRuaVNXy7a9mrdYTbpIVzfNNHvgaLFKT+7hvSfoF/0DFESDNOBi
         dNEQXSJ9Dey652wIgHl34vrGuekgNfwYVELFjOaU=
Date:   Wed, 21 Jul 2021 12:24:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zhenguo Zhao <zhenguo6858@gmail.com>
Cc:     jirislaby@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: n_gsm: delete CLD command frame as requester
Message-ID: <YPf12Vjrce7Ls/6W@kroah.com>
References: <1625119085-18200-1-git-send-email-zhenguo6858@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1625119085-18200-1-git-send-email-zhenguo6858@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 01, 2021 at 01:58:05PM +0800, Zhenguo Zhao wrote:
> From: Zhenguo Zhao <Zhenguo.Zhao1@unisoc.com>
> 
> as initiator,it may be send CLD conmmand ,as requester,there is
> no need to send the CLD control frame,it will cause redundant data.

Same issue here.

And please make this a patch series, properly numbered, so we can track
them all together.

thanks,

greg k-h
