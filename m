Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9FE53A0990
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 03:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbhFIBqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 21:46:10 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:50551 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbhFIBqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 21:46:09 -0400
Received: (Authenticated sender: n@nfraprado.net)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 2DDFB60004;
        Wed,  9 Jun 2021 01:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nfraprado.net;
        s=gm1; t=1623203054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=tHl203Zaulu9R4l03LoKzVS64z8W71qCWI26IsznQy4=;
        b=ojVwy1rvMa2XENDZgJ6WJntPmfRtT6S9s5EjW3HGUIWzuwR+UFlpHSqNGb6634Z+Pd6Qrt
        R6c/drQQYUx5eM8O53GmgzO2IuRjYCrCMHyXQJyho1RWdVLnn/SwK9zym2tUBgRfZdmDF4
        DKHqM28+46GD2ZsnP4rVSn8I5fvfORvi3gp9Yz+FRBk6nW/sW4iZOAKnPLWrOiH7opzRzG
        DOkgbQ2w+aWkvfjsG9NG7qpNMNYTCswcVnaacjcWiqvAw0Zx8p1NPiBqBAhCkcWfOY0a0a
        3yhFe8qqgsGeQzNYaNt3t+miGrgS3Bp5kFx/zSo0pnkTOnei6SgdkYGEvd5Tgg==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <n@nfraprado.net>
To:     linux-doc@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>,
        ~lkcamp/patches@lists.sr.ht
Subject: [RFC PATCH 0/2] docs: automarkup.py: Add literal markup of known constants
Date:   Tue,  8 Jun 2021 22:43:06 -0300
Message-Id: <20210609014308.234027-1-n@nfraprado.net>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

a while back Matthew suggested adding automatic markup of known constants, like
NULL and error codes, as literals [1]. This is a great idea since those literals
are very frequently used throughout the documentation and are fixed names, so we
can easily match them without false positives and make the source files less
cluttered.

Patch 1 adds that feature to automarkup.py, while patch 2 removes the no longer
needed markup from the xarray.rst file which was given as an example.

Some things I'd like to discuss:

* As a first draft I added the constants I found on xarray.rst plus all error
  codes from errno-base.h and errno.h. We don't need to start with everything,
  but we can certainly do better than this. What are common constants that
  should be added here? (Matthew mentioned ANSI C or POSIX, some reference to
  the constants in those would be great, even more if they are easily parsable)

* The Literals list added is already a bit big with just the error codes, so
  perhaps we should move them to a separate plain text file that is read on
  startup?

* There was also mention of automatically converting uppercase words to
  literals. I'm not so sure about that one so I left it out for now.

  The example given was XA_MARK_0, which is a #define in xarray.h. The way
  to go here is certainly to first use kernel-doc to get it included in the
  documentation, and then cross-reference to it. FWICT at the moment kernel-doc
  for defines should be done like for functions (but the parenthesis can be
  omitted, although they show up in the output):

	/**
	  * XA_MARK_0 - Brief description.
	  *
	  * Description of the type.
	  */

  At the current state, the cross-reference would then need to be done either
  through plain :c:macro:`XA_MARK_0`, or, by relying on automarkup, typedef
  XA_MARK_0 (which is not ideal since this isn't a typedef). Options for
  improvements would be to add 'macro' as a possible prefix (so eg. macro
  XA_MARK_0), or go all out and try to cross-reference on every uppercase word
  like suggested. We should strive for what is the most natural to write, as
  long as the regex isn't too broad.

  Since automarkup.py is opt-out rather than opt-in, I think we should be extra
  careful not to make the regexes too broad, even if in this case it relies on a
  C symbol being present.

  One other idea I had was that we could limit to all uppercase words as
  long as it has an _ on it, since I don't expect we would get false positives
  with that. The downside is that it might be very confusing to people why their
  MACRONAME isn't being automatically cross-referenced to...

Thanks,
Nícolas

[1] https://lore.kernel.org/linux-doc/20201007234024.GY20115@casper.infradead.org/

Nícolas F. R. A. Prado (2):
  docs: automarkup.py: Add literal markup of known constants
  XArray: Remove literal markup from known constants

 Documentation/core-api/xarray.rst  | 48 +++++++++++++++---------------
 Documentation/sphinx/automarkup.py | 45 ++++++++++++++++++++++++++--
 2 files changed, 67 insertions(+), 26 deletions(-)

-- 
2.32.0

