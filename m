Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D372305010
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 04:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236877AbhA0Dnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:43:52 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:51512 "EHLO
        hera.aquilenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728508AbhAZWWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 17:22:48 -0500
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id 0E1D637A;
        Tue, 26 Jan 2021 23:22:04 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id TK6zzAou9Sm9; Tue, 26 Jan 2021 23:22:03 +0100 (CET)
Received: from begin (unknown [IPv6:2a01:cb19:956:1b00:de41:a9ff:fe47:ec49])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id 31AE1365;
        Tue, 26 Jan 2021 23:22:03 +0100 (CET)
Received: from samy by begin with local (Exim 4.94)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1l4Wio-00G9gs-I8; Tue, 26 Jan 2021 23:22:02 +0100
Date:   Tue, 26 Jan 2021 23:22:02 +0100
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, speakup@linux-speakup.org
Subject: Re: [PATCH 1/4] This merely adds the missing synth parameter to all
 io functions.
Message-ID: <20210126222202.pcfsuj54dyjvfzuk@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
        speakup@linux-speakup.org
References: <20210111223737.697336-1-samuel.thibault@ens-lyon.org>
 <20210111223737.697336-2-samuel.thibault@ens-lyon.org>
 <YBBhgVZpTn9T2eL5@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YBBhgVZpTn9T2eL5@kroah.com>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
X-Spamd-Bar: --
Authentication-Results: hera.aquilenet.fr
X-Rspamd-Server: hera
X-Rspamd-Queue-Id: 0E1D637A
X-Spamd-Result: default: False [-2.46 / 15.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_THREE(0.00)[3];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         HAS_ORG_HEADER(0.00)[];
         RCVD_COUNT_THREE(0.00)[3];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MID_RHS_NOT_FQDN(0.50)[];
         BAYES_HAM(-2.96)[99.81%]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH, le mar. 26 janv. 2021 19:37:53 +0100, a ecrit:
> Can you fix this up and resend the series?

Yep! done so.

Samuel
