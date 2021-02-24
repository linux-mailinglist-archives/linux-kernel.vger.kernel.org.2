Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A88B432399D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 10:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234635AbhBXJi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 04:38:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:44586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234656AbhBXJie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 04:38:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 05B3164E2B;
        Wed, 24 Feb 2021 09:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614159473;
        bh=XMs7FqMnHseLFwajEV3o4YACWAO6IOJ8nmbQCvsXrDk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZPfNOxTzwi8NzJCXZKGXWyyDOPDHP05dMloL7OEragvQZhkugnDPowkXc9UcbIMcU
         4PA3WrQHRhYeL1+CDHaZrnPxoUvfklvkr2k0+MxPwLNj+T8D5y0o7SpnOqFNdenucJ
         PlSyidkBeeCDVbhRApMGtftU7l3RCs9cnN7D3PvVj3TVh+NlEykyh71EtBHk88t4ma
         5sXIZ2rmOL55qtpjy1EZIVI1J1twEC+lMVgp2fwra3y+0GDWuXvj/9fHCZqVVI2pHH
         em6rrnQt+yGAYX94kT4p4qLZM6/6D2S0L7S4nyp/ku7PqCHneaMIfXGJIwF35ustg8
         5XofU1uRvn9TA==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lEqcU-0007EZ-5K; Wed, 24 Feb 2021 10:38:10 +0100
Date:   Wed, 24 Feb 2021 10:38:10 +0100
From:   Johan Hovold <johan@kernel.org>
To:     dingsenjie@163.com
Cc:     linux-kernel@vger.kernel.org, dingsenjie <dingsenjie@yulong.com>
Subject: Re: [PATCH] gnss: ubx: Simplify the return expression in the ubx.c
Message-ID: <YDYegicquZNynwyG@hovoldconsulting.com>
References: <20210224092947.17724-1-dingsenjie@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210224092947.17724-1-dingsenjie@163.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021 at 05:29:47PM +0800, dingsenjie@163.com wrote:
> From: dingsenjie <dingsenjie@yulong.com>
> 
> Simplify the return expression.

This was done on purpose (keep error paths separate from success) so no
need to "simplify".

Johan
