Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C76CE38ACEE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 13:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241647AbhETLve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 07:51:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:59368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242823AbhETLlv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 07:41:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EE82D61090;
        Thu, 20 May 2021 11:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621510830;
        bh=4VLx8lBWx60j8Rnpb2kOFGy6HZWa8DKG5xF75+bN838=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QvT1ZADHByiZXs6hHYtGV8g+AkdVh5nQ8jj0Jh5Nx3utoEOZ2nmE6LSqFEfKr6xbh
         pHFPgHv9P1EOuZJUxxfWRhWF9HfODGCyNTLYydiib8AaakFFl7hRVvoaFcqB6m7Blr
         0rk1xfWokPF2/fb0Lfq4lL/d0sJ0aKoBsOr9aM4eIaIpmwOO7xn10phis2KXerFt4y
         63ueWK9eVK8FJf31QU/ZPbL1qjss48geLtq9yk2GZyXg5hbIeNaj7kJsEv/4uKIG/v
         aObyzxXQo3OtLKCA3CngF0sC43/m/e5aL3xWRsMxZQXodyQN1YN2VO45DvKCqpSa05
         TFvllRbCBlkxA==
Received: by pali.im (Postfix)
        id 3958B9D1; Thu, 20 May 2021 13:40:28 +0200 (CEST)
Date:   Thu, 20 May 2021 13:40:28 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 mvebu + mvebu/dt64 6/6] arm64: dts: marvell:
 armada-37xx: move firmware node to generic dtsi file
Message-ID: <20210520114028.xn3lovh3npja4ktw@pali>
References: <20210308153703.23097-1-kabel@kernel.org>
 <20210506090802.14268-1-pali@kernel.org>
 <20210506090802.14268-6-pali@kernel.org>
 <YJsobDuLvxpr4aVr@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YJsobDuLvxpr4aVr@lunn.ch>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 12 May 2021 02:59:24 Andrew Lunn wrote:
> On Thu, May 06, 2021 at 11:08:02AM +0200, Pali Rohár wrote:
> > Move the turris-mox-rwtm firmware node from Turris MOX' device tree into
> > the generic armada-37xx.dtsi file and use the generic compatible string
> > 'marvell,armada-3700-rwtm-firmware' instead of the current one.
> > 
> > The Turris MOX rWTM firmware can be used on any Armada 37xx device,
> > giving them access to the rWTM hardware random number generator, which
> > is otherwise unavailable.
> 
> This is a new feature, not a fix. Please split this patchset up into
> fixes, which get applied to stable, and new features which will get
> merged during the next merge window.

Done, I have split patches into two patch series, so they can be
reviewed and merged separately.
