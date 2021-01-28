Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0BCF307D36
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 18:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbhA1R6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 12:58:16 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:36842 "EHLO
        hera.aquilenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbhA1R4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 12:56:37 -0500
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id 7C76431F;
        Thu, 28 Jan 2021 18:55:51 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JHKc1Q1vr65C; Thu, 28 Jan 2021 18:55:50 +0100 (CET)
Received: from begin (unknown [IPv6:2a01:cb19:956:1b00:de41:a9ff:fe47:ec49])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id C1B7322;
        Thu, 28 Jan 2021 18:55:50 +0100 (CET)
Received: from samy by begin with local (Exim 4.94)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1l5BWH-007kZi-Hj; Thu, 28 Jan 2021 18:55:49 +0100
Date:   Thu, 28 Jan 2021 18:55:49 +0100
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, speakup@linux-speakup.org
Subject: Re: [PATCH] speakup: Make dectlk flush timeout configurable
Message-ID: <20210128175549.j5mc72mjjnh6aalk@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
        speakup@linux-speakup.org
References: <20210127234444.1038813-1-samuel.thibault@ens-lyon.org>
 <YBJtqGn/ZpdFpNlg@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YBJtqGn/ZpdFpNlg@kroah.com>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
X-Spamd-Bar: --
Authentication-Results: hera.aquilenet.fr
X-Rspamd-Server: hera
X-Rspamd-Queue-Id: 7C76431F
X-Spamd-Result: default: False [-2.50 / 15.00];
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
         BAYES_HAM(-3.00)[100.00%]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH, le jeu. 28 janv. 2021 08:54:16 +0100, a ecrit:
> On Thu, Jan 28, 2021 at 12:44:44AM +0100, Samuel Thibault wrote:
> >  static struct kobj_attribute full_time_attribute =
> >  	__ATTR(full_time, 0644, spk_var_show, spk_var_store);
> > +static struct kobj_attribute flush_time_attribute =
> > +	__ATTR(flush_time, 0644, spk_var_show, spk_var_store);
> 
> __ATTR_RW()?

Unfortunately no because __ATTR_RW only takes the name, and uses that
for the function to be called. In our case the functions are shared.

> Also, no Documentation/ABI/ update for the new one user-visable
> attribute?  Please fix up.

Right, I'll fix it.

Samuel
