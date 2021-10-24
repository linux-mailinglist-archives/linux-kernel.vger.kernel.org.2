Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6F77438CAC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 01:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbhJXX7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 19:59:21 -0400
Received: from smtprelay0032.hostedemail.com ([216.40.44.32]:51144 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229821AbhJXX7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 19:59:20 -0400
Received: from omf15.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 43DB8182CED2A;
        Sun, 24 Oct 2021 23:56:58 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf15.hostedemail.com (Postfix) with ESMTPA id 2016CC417C;
        Sun, 24 Oct 2021 23:56:56 +0000 (UTC)
Message-ID: <a7d1136e22bdb37170a0fe9a9443ba0cdf5dcd32.camel@perches.com>
Subject: Re: [PATCH v2 8/8] staging: vchiq_core: fix quoted strings split
 across lines
From:   Joe Perches <joe@perches.com>
To:     Gaston Gonzalez <gascoar@gmail.com>, linux-staging@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, nsaenz@kernel.org,
        stefan.wahren@i2se.com, arnd@arndb.de, dan.carpenter@oracle.com,
        ojaswin98@gmail.com, amarjargal16@gmail.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
Date:   Sun, 24 Oct 2021 16:56:55 -0700
In-Reply-To: <20211024213839.370830-1-gascoar@gmail.com>
References: <20211024212844.370379-1-gascoar@gmail.com>
         <20211024213839.370830-1-gascoar@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 2016CC417C
X-Spam-Status: No, score=-2.25
X-Stat-Signature: yr4qrywder1hotmtejquq6bkcb6snz94
X-Rspamd-Server: rspamout01
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+ByG/C+1voGOqhYuSK4/VprHDSFEyHuBk=
X-HE-Tag: 1635119816-195226
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2021-10-24 at 18:38 -0300, Gaston Gonzalez wrote:
> Quoted strings should not be split across lines. As put it in [1]:
> "never break user-visible strings such as printk messages because that
> breaks the ability to grep for them."
> 
> While at it, fix the alignment of the arguments in the sentence.
> 
> Note: this introduce a checkpatch CHECK: line length of 123 exceeds 100
> columns, as the line now is:
> 
>  vchiq_loud_error("%d: service %d (%c%c%c%c) version mismatch - local (%d, min %d) vs. remote (%d, min %d)",
> 
> But now the string is grep-able and the whole function call more
> clear.

IMO: All of these should be changed

drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h:#define VCHIQ_LOG_PREFIX   KERN_INFO "vchiq: "
drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h-
drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h-#ifndef vchiq_log_error
drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h-#define vchiq_log_error(cat, fmt, ...) \
drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h- do { if (cat >= VCHIQ_LOG_ERROR) \
drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h:         printk(VCHIQ_LOG_PREFIX fmt "\n", ##__VA_ARGS__); } while (0)
drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h-#endif
drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h-#ifndef vchiq_log_warning
drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h-#define vchiq_log_warning(cat, fmt, ...) \
drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h- do { if (cat >= VCHIQ_LOG_WARNING) \
drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h:          printk(VCHIQ_LOG_PREFIX fmt "\n", ##__VA_ARGS__); } while (0)
drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h-#endif
drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h-#ifndef vchiq_log_info
drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h-#define vchiq_log_info(cat, fmt, ...) \
drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h- do { if (cat >= VCHIQ_LOG_INFO) \
drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h:         printk(VCHIQ_LOG_PREFIX fmt "\n", ##__VA_ARGS__); } while (0)
drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h-#endif
drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h-#ifndef vchiq_log_trace
drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h-#define vchiq_log_trace(cat, fmt, ...) \
drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h- do { if (cat >= VCHIQ_LOG_TRACE) \
drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h:         printk(VCHIQ_LOG_PREFIX fmt "\n", ##__VA_ARGS__); } while (0)
drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h-#endif
drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h-
drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h-#define vchiq_loud_error(...) \
drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h- vchiq_log_error(vchiq_core_log_level, "===== " __VA_ARGS__)
drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h-

I suggest using the rather more common vchiq_err, vchiq_warn, vchiq_info
and if necessary vchiq_trace.  Also the cat >= test is unnecessary and
this should just use the more common standard logging facilities.

vchiq_loud_error is IMO unnecessary.

Also several of the uses of these macros already have '\n' terminations
so that just adds unnecessary blank lines in the logging.


