Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C148366D13
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242728AbhDUNoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242749AbhDUNoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:44:08 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36AF6C06138A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 06:43:34 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lZD8e-00ElCk-Gn; Wed, 21 Apr 2021 15:43:32 +0200
Message-ID: <911d4b8d3e9c68860ef4163fc4cce3b5fbb485c5.camel@sipsolutions.net>
Subject: Re: [PATCH 070/190] Revert "rfkill: Fix incorrect check to avoid
 NULL pointer dereference"
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Aditya Pakki <pakki001@umn.edu>
Date:   Wed, 21 Apr 2021 15:43:31 +0200
In-Reply-To: <20210421130105.1226686-71-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
         <20210421130105.1226686-71-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-04-21 at 12:59 +0000, Greg Kroah-Hartman wrote:
> This reverts commit 6fc232db9e8cd50b9b83534de9cd91ace711b2d7.

This commit was fine, though the commit log is misleading since there's
no dereference yet, just a pointer calculation. I may not have seen that
at the time, or have decided that the slight commit log inaccuracy
didn't matter.

I'm inclined towards keeping it, since it removed a BUG_ON(), but
there's no reasonable scenario where somebody could end up calling this
function with a NULL pointer.

johannes

