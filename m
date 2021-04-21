Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD964366CFE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242181AbhDUNk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241563AbhDUNkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:40:23 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C664C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 06:39:50 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lZD52-00El6r-LC; Wed, 21 Apr 2021 15:39:48 +0200
Message-ID: <685d055406cb9fd28fec3ac0b9ba3fc3fe039f08.camel@sipsolutions.net>
Subject: Re: [PATCH 069/190] Revert "mac80211: Remove redundant assertion"
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Aditya Pakki <pakki001@umn.edu>
Date:   Wed, 21 Apr 2021 15:39:47 +0200
In-Reply-To: <20210421130105.1226686-70-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
         <20210421130105.1226686-70-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-04-21 at 12:59 +0000, Greg Kroah-Hartman wrote:
> This reverts commit 1ee7826ab68f7e9fa1a01533983acf6a6f62e297.
> 

That commit was actually correct, though sort of irrelevant. I think we
can go either way on it, but better not spend any (more) time on it.

johannes

