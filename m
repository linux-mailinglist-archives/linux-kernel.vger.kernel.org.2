Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F87341EAB9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 12:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353438AbhJAKN0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 1 Oct 2021 06:13:26 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:43656 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbhJAKNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 06:13:25 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id BA9DA1C0B80; Fri,  1 Oct 2021 12:11:39 +0200 (CEST)
Date:   Fri, 1 Oct 2021 12:11:38 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Oskari Pirhonen <xxc3ncoredxx@gmail.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH] tty/sysrq: More intuitive Shift handling
Message-ID: <20211001101137.GA2554@bug>
References: <YU/6SCmUr9qGkqBu@dj3ntoo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <YU/6SCmUr9qGkqBu@dj3ntoo>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2021-09-25 23:42:48, Oskari Pirhonen wrote:
> Make Alt-SysRq-Shift-<key> behave like Alt-Shift-SysRq-<key>.
> 
> Signed-off-by: Oskari Pirhonen <xxc3ncoredxx@gmail.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
