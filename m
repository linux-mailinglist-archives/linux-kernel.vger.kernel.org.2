Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9FB43BA2B5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 17:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbhGBPYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 11:24:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:35812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229761AbhGBPYj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 11:24:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6665761206;
        Fri,  2 Jul 2021 15:22:05 +0000 (UTC)
Date:   Fri, 2 Jul 2021 17:22:03 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Rodrigo Campos <rodrigo@kinvolk.io>
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org,
        containers@lists.linux.dev, Alban Crequy <alban@kinvolk.io>,
        Mauricio =?utf-8?Q?V=C3=A1squez?= Bernal <mauricio@kinvolk.io>,
        Sargun Dhillon <sargun@sargun.me>
Subject: Re: [PATCH] Documentation: seccomp: Fix typo in user notification
Message-ID: <20210702152203.injvt65gceq43swo@wittgenstein>
References: <20210702151927.263402-1-rodrigo@kinvolk.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210702151927.263402-1-rodrigo@kinvolk.io>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 02, 2021 at 05:19:27PM +0200, Rodrigo Campos wrote:
> The close on exec flag is O_CLOEXEC, not O_EXEC. This patch just fixes
> the typo.
> 
> Suggested-by: Christian Brauner <christian.brauner@ubuntu.com>
> Signed-off-by: Rodrigo Campos <rodrigo@kinvolk.io>
> ---

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
