Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 758C83969DA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 00:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232505AbhEaW41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 18:56:27 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:55986 "EHLO
        hera.aquilenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232463AbhEaW4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 18:56:22 -0400
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id 06D38CB8;
        Tue,  1 Jun 2021 00:54:40 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 22ef2t8sQ_v0; Tue,  1 Jun 2021 00:54:39 +0200 (CEST)
Received: from begin (unknown [IPv6:2a01:cb19:956:1b00:de41:a9ff:fe47:ec49])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id 52289281;
        Tue,  1 Jun 2021 00:54:39 +0200 (CEST)
Received: from samy by begin with local (Exim 4.94.2)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1lnqnu-004DB9-80; Tue, 01 Jun 2021 00:54:38 +0200
Date:   Tue, 1 Jun 2021 00:54:38 +0200
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Didier Spaier <didier@slint.fr>,
        Igor Matheus Andrade Torrente <igormtorrente@gmail.com>,
        speakup@linux-speakup.org, corbet@lwn.net,
        gregkh@linuxfoundation.org, grandmaster@al2klimov.de,
        rdunlap@infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: docs: Convert the Speakup guide to rst
Message-ID: <20210531225438.rrxr4ceo7pv34mvo@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Didier Spaier <didier@slint.fr>,
        Igor Matheus Andrade Torrente <igormtorrente@gmail.com>,
        speakup@linux-speakup.org, corbet@lwn.net,
        gregkh@linuxfoundation.org, grandmaster@al2klimov.de,
        rdunlap@infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210531215737.8431-1-igormtorrente@gmail.com>
 <20210531220754.h4ep2dj65wl6hejf@begin>
 <393c2df8-9cb1-f428-5629-6e98c078c24f@slint.fr>
 <20210531224431.q4hya673p4ckbxft@begin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210531224431.q4hya673p4ckbxft@begin>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
X-Spamd-Bar: --
Authentication-Results: hera.aquilenet.fr
X-Rspamd-Server: hera
X-Rspamd-Queue-Id: 06D38CB8
X-Spamd-Result: default: False [-2.50 / 15.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         MIME_GOOD(-0.10)[text/plain];
         HAS_ORG_HEADER(0.00)[];
         RCVD_COUNT_THREE(0.00)[3];
         RCPT_COUNT_SEVEN(0.00)[9];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MID_RHS_NOT_FQDN(0.50)[];
         BAYES_HAM(-3.00)[100.00%]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Samuel Thibault, le mar. 01 juin 2021 00:44:31 +0200, a ecrit:
> Didier Spaier, le mar. 01 juin 2021 00:42:22 +0200, a ecrit:
> > And anyway can we just provide a link to the web page that will be built
> > from the rst file?
> 
> We probably can yes.

AIUI it would end up on
https://www.kernel.org/doc/html/latest/

Samuel
