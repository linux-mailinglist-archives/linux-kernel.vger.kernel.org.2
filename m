Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99915441F5E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 18:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbhKARgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 13:36:07 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:45022 "EHLO
        hera.aquilenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbhKARgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 13:36:03 -0400
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id 8BE71254;
        Mon,  1 Nov 2021 18:33:23 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id NXl-a-GsqB5e; Mon,  1 Nov 2021 18:33:23 +0100 (CET)
Received: from begin.home (unknown [IPv6:2a01:cb19:956:1b00:de41:a9ff:fe47:ec49])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id 1D835B5;
        Mon,  1 Nov 2021 18:33:23 +0100 (CET)
Received: from samy by begin.home with local (Exim 4.95)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1mhbBR-00DO9I-US;
        Mon, 01 Nov 2021 18:33:21 +0100
Date:   Mon, 1 Nov 2021 18:33:21 +0100
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Colin Ian King <colin.i.king@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-doc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] speakup: Fix typo in documentation "boo" -> "boot"
Message-ID: <20211101173321.dqdhtsgh35tzgndx@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Colin Ian King <colin.i.king@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-doc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211028182319.613315-1-colin.i.king@gmail.com>
 <20211028182451.baizgvczghh37zfl@begin>
 <87k0hr6bfx.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k0hr6bfx.fsf@meer.lwn.net>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
X-Spamd-Bar: +
X-Spam-Level: *
X-Rspamd-Server: hera
Authentication-Results: hera.aquilenet.fr;
        none
X-Rspamd-Queue-Id: 8BE71254
X-Spamd-Result: default: False [1.90 / 15.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         RCPT_COUNT_FIVE(0.00)[6];
         HAS_ORG_HEADER(0.00)[];
         RCVD_COUNT_THREE(0.00)[3];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_TLS_LAST(0.00)[];
         FREEMAIL_CC(0.00)[googlemail.com,linuxfoundation.org,vger.kernel.org];
         MID_RHS_NOT_FQDN(0.50)[];
         SUSPICIOUS_RECIPS(1.50)[]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Corbet, le lun. 01 nov. 2021 11:19:14 -0600, a ecrit:
> But, Samuel, while you're on the line, whatever happened to the RST
> conversion for this document?  I'd sure like to get that (and the
> associated license change) merged...

I haven't found a contact address for the original author, Gene Collins,
so we still don't have an ack on the licence change.

Samuel
