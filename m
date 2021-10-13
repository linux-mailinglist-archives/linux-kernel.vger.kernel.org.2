Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA3B142C10B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 15:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235111AbhJMNMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 09:12:53 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:54320 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234141AbhJMNMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 09:12:51 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D7AA4223A9;
        Wed, 13 Oct 2021 13:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1634130647; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xjbdvaA4ZdoyvOHkqVZsi44zAS/VfGrBJ1QOUh3agHU=;
        b=l6mpZTNhIhoGkAlyHBMGXsaesuKV4dOmQiihDtCVMZGzz2dAwAVnDr/Ww45wZEItYC2vqY
        Bh+zWtls5wOsjoyU/X14ePHN3iBJu24y1qU+jTHIENI+9k6J5KQSb7vZdUdoQ3AtXSu9HC
        shfzDf4p+GBibRS05CVddDzOvO9eB1s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1634130647;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xjbdvaA4ZdoyvOHkqVZsi44zAS/VfGrBJ1QOUh3agHU=;
        b=H2WjVGWHU0AOVljgS5undYZM6KjSPh3nGBtYFYerTzgBYfdhkCOgem6wkGdqDDuEYYBBeD
        j1S9up3tGYiSAmDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CF95213CF2;
        Wed, 13 Oct 2021 13:10:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vICmMtfaZmFtJgAAMHmgww
        (envelope-from <bp@suse.de>); Wed, 13 Oct 2021 13:10:47 +0000
Date:   Wed, 13 Oct 2021 15:10:50 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Andrew Halaney <ahalaney@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] init: Make unknown command line param message clearer
Message-ID: <YWba2gIhDaSnBFTz@zn.tnic>
References: <20211012213523.39801-1-ahalaney@redhat.com>
 <20211012200106.1afdbb0b@gandalf.local.home>
 <87853d4f-d6f8-1d58-1a07-c8232dae87fd@infradead.org>
 <20211013125638.4nc4bnbzbeixfrii@halaneylaptop>
 <20211013090333.19d55216@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211013090333.19d55216@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 09:03:33AM -0400, Steven Rostedt wrote:
> Just enough info that makes sense, and have comments or documentation
> elsewhere that can explain more details.

Yes, as we do, for example in:

f77f420d3475 ("x86/msr: Add a pointer to an URL which contains further details")

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
