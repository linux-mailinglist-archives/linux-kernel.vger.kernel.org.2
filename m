Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECC223BC612
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 07:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbhGFF3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 01:29:36 -0400
Received: from angie.orcam.me.uk ([78.133.224.34]:60336 "EHLO
        angie.orcam.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbhGFF3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 01:29:36 -0400
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id D51A692009C; Tue,  6 Jul 2021 07:26:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id CD9A992009B;
        Tue,  6 Jul 2021 07:26:56 +0200 (CEST)
Date:   Tue, 6 Jul 2021 07:26:56 +0200 (CEST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Jean Delvare <jdelvare@suse.com>
cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] firmware: dmi: Avoid (some) empty names in kernel log
Message-ID: <alpine.DEB.2.21.2107051831260.33206@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 I've noticed one of my systems shows this output in the kernel log:

Legacy DMI 2.0 present.
DMI:  /i430HX, BIOS 4.51 PG 05/13/98

which leaves something to desire.  While the contents of /sys/firmware/dmi 
remain the main source of DMI data, along with output from `dmidecode', 
the summary from the kernel log is often readily available with various 
reports, making it a point of easy reference.  Therefore I think empty 
names are best avoided if possible.

 The system in question is a Tyan Tomcat IV S1564D mainboard, which has 
its System Information all empty, not unreasonably as it was sold as a 
bare board for field integration rather that a complete system.  It does 
have the manufacturer correctly recorded with Base Board Information 
though.

 I have therefore made this mini patch series, with 2/2 printing the board 
manufacturer if none has been given for the system, and including 1/2 as 
well to prevent a trailing slash with an empty board name, following my 
observation made with an unrelated issue where the reporter included a log 
with just "/" shown as the system name.

 See individual change descriptions for further details.

 Please apply.

  Maciej
