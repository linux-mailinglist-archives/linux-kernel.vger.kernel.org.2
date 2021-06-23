Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C71CB3B212C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 21:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbhFWTZm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 23 Jun 2021 15:25:42 -0400
Received: from smtprelay0181.hostedemail.com ([216.40.44.181]:34270 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230523AbhFWTZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 15:25:23 -0400
X-Greylist: delayed 414 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Jun 2021 15:25:23 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave01.hostedemail.com (Postfix) with ESMTP id 48F5C1807EC00
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 19:16:11 +0000 (UTC)
Received: from omf04.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 31987100E7B53
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 19:16:10 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: m@hardcastle.com) by omf04.hostedemail.com (Postfix) with ESMTPA id C9D15D1516
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 19:16:09 +0000 (UTC)
From:   Matt Hardcastle <m@hardcastle.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: [RFC] reconsider [PATCH] hostname up to 255 character
Message-Id: <A27A5542-69CD-4B7F-86C5-6940179988B0@hardcastle.com>
Date:   Wed, 23 Jun 2021 12:16:08 -0700
To:     linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.3654.100.0.2.22)
X-Spam-Status: No, score=-2.36
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: C9D15D1516
X-Stat-Signature: 9e9szt7kpekyieiya855yfyxzzrj5ses
X-Session-Marker: 6D4068617264636173746C652E636F6D
X-Session-ID: U2FsdGVkX18zXESlhS6YiXy3gtsmlc6/m9/BugK6Ros=
X-HE-Tag: 1624475769-300618
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In 2006 Randy Dunlap submitted a patch [^1] to increase the supported hostname length to 255 characters. There was some discussion on the patch, but it appeared to go stale.

Are you open to reconsidering the change?

- m@

^1 https://lore.kernel.org/lkml/20060525204534.4068e730.rdunlap@xenotime.net/
