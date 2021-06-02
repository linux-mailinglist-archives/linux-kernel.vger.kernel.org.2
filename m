Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F39B1397DD7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 03:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbhFBBCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 21:02:44 -0400
Received: from befuddled.reisers.ca ([206.248.184.127]:57820 "EHLO
        befuddled.reisers.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbhFBBCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 21:02:35 -0400
Received: by befuddled.reisers.ca (Postfix, from userid 65534)
        id A4141382581; Tue,  1 Jun 2021 20:55:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=reisers.ca;
        s=befuddled; t=1622595345;
        bh=7l945M6cdmhQCZ4oD40xLF7t8MXTqtcGK04d5qAA3VI=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=BfGdG7PWyI603MqfnEF/vwq9cwna2VFNeb9wfUeKZJp+H6B31was4LWvd0DmwpkNL
         4WvFI3Bg0/FXLk9e8YTu/G0dZzYORIaN3rxks8evTDHZZKbmjssiEUew5cceCYlRai
         KLLSkhdOy0yidaORNdkdOtGoVGskISwLan86DBiM=
Received: from localhost (localhost [IPv6:::1])
        by befuddled.reisers.ca (Postfix) with ESMTPS id C07D6380EFE;
        Tue,  1 Jun 2021 20:55:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=reisers.ca;
        s=befuddled; t=1622595344;
        bh=7l945M6cdmhQCZ4oD40xLF7t8MXTqtcGK04d5qAA3VI=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=ix+ILaTzR4T2/mvNLeMYzNCaaP67OF5MWSwIsV/d/j4JuJV1IjVoLgNEPktaXWm+7
         EHEpBmY7Mfw1RlLQ4f7ck1id6bCSTpPIj0QBjh3HB9i7iw3zdM5lkX9ENL5xtApLV/
         7+JGQb4WrPeAoOz5WodGKO6M+FCmtkQIUdAmqYrc=
Date:   Tue, 1 Jun 2021 20:55:44 -0400 (EDT)
From:   Kirk Reiser <kirk@reisers.ca>
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>
cc:     speakup@linux-speakup.org, Jonathan Corbet <corbet@lwn.net>,
        Christopher Brannon <chris@the-brannons.com>,
        William Hubbs <w.d.hubbs@gmail.com>,
        Steve Holmes <steve.holmes88@gmail.com>,
        Igor Matheus Andrade Torrente <igormtorrente@gmail.com>,
        gregkh@linuxfoundation.org, grandmaster@al2klimov.de,
        rdunlap@infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs: Convert the Speakup guide to rst
In-Reply-To: <afc570ec-dfe1-2a37-6fd3-aeaefece4aa6@reisers.ca>
Message-ID: <fe1265e9-7914-aee9-08e-ca2ac539fd73@reisers.ca>
References: <20210531215737.8431-1-igormtorrente@gmail.com> <875yyxbenm.fsf@meer.lwn.net> <20210601220643.uzep2ju2zlcmpa57@begin> <874keh9qk9.fsf@meer.lwn.net> <20210601223743.carif4gkzcz5jo7j@begin> <20210601224452.sqblwctwiu47xgqg@begin>
 <20210601224554.6kc5syoy2tscisiv@begin> <20210601224854.iug2arwes64k7fxr@begin> <afc570ec-dfe1-2a37-6fd3-aeaefece4aa6@reisers.ca>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-Bogosity: Ham, tests=bogofilter, spamicity=0.000000, version=1.2.5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Um, make that gene@collinsnet.net. I need new fingers obviously.
