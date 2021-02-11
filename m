Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D498631861E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 09:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbhBKIKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 03:10:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:33406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229469AbhBKIKB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 03:10:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6786D64E7D;
        Thu, 11 Feb 2021 08:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613030960;
        bh=vyMMhB7wPQd8gGS0ecVy6MdwiL8lTI6K+XerVHtB99Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XHnzYfUpxeSOPEybDRAv0ofgKGYTaRh///nVnG/PDSxTrlom+oSixIV2bPAP/ZTGN
         dU8vpKSfAz4YW7+bH/31HhkWZOx/rx/pARQNu5ePkYv2HeNW1fEHTGaF4ssVD32uPT
         ClNNdTsl8S7y5vP6rmoPeIRfUP2pspOrG+fZ8S6CQibjRavbOrJcjIQI7iBrk227sZ
         uHzjUO2gXqT91z8uqqQDdX40DkfMWOVTvO8CFL28L04t8NH7Z+luLYngiiEaIJ4BRo
         a7VuwH1e4vfxDCDt7UYgWI2rB4tHLZzwb3PpcRMzmyqdoTaZ3+8IsUwWhQ70DvDh8C
         Gkl5P/kT8Z55g==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lA72d-0004eu-99; Thu, 11 Feb 2021 09:09:35 +0100
Date:   Thu, 11 Feb 2021 09:09:35 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>, linux-usb@vger.kernel.org
Subject: Re: [PATCH] usb: Replace lkml.org links with lore
Message-ID: <YCTmP9F0XVR8iF19@hovoldconsulting.com>
References: <20210210235330.3292719-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210235330.3292719-1-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 03:53:30PM -0800, Kees Cook wrote:
> As started by commit 05a5f51ca566 ("Documentation: Replace lkml.org
> links with lore"), replace lkml.org links with lore to better use a
> single source that's more likely to stay available long-term.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Johan Hovold <johan@kernel.org>
