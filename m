Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4262832132E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 10:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbhBVJd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 04:33:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbhBVJcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 04:32:20 -0500
X-Greylist: delayed 1359 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 22 Feb 2021 01:31:40 PST
Received: from filter03-ipv6-out05.totaalholding.nl (filter03-ipv6-out05.totaalholding.nl [IPv6:2a02:c207:2038:8169::5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668D4C061786
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 01:31:40 -0800 (PST)
Received: from www98.totaalholding.nl ([185.94.230.81])
        by filter03.totaalholding.nl with esmtps (TLSv1.2:AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <mjbaars1977.gcc@cyberfiber.eu>)
        id 1lE7D6-0003ME-Cl
        for linux-kernel@vger.kernel.org; Mon, 22 Feb 2021 10:08:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=cyberfiber.eu; s=default; h=MIME-Version:Content-Type:Date:To:From:Subject:
        Message-ID:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=qn45xVVWSQjH5R6yy6NnJXSlgcDDV4KN3EY2K2ine1w=; b=GpHxLVhF/Xr+K7gzZ9lUEc8p92
        1jSynsoPncbRtIV1Pk1nefGjByYJ9dzBNxOVFoEbbxJ95ObhzhvZokyRADKV8pws105YuGwz78bsg
        uXsdJt9lyZUk44gQ+sEfepxVVeKMvj1D0rBCzxwREIGM0qaG/6mno62cqIQzHbcW3OcI+29TM1i7n
        lEsNE1jDLK+1Xa3hqm9Zt08FfzcwB4nVO77w05KR8Znp3qCxslyVXuGJwvTa14ACpp0oY+yyCleE5
        BPB9is6vhqxtBzIZacrjsk7WAWbpetObBAyuorSINf5/CopWNgDqax4A6L9zTHCN6pfYm3+DILySr
        ZnwFhATw==;
Received: from 82-94-23-232.ip.xs4all.nl ([82.94.23.232]:45070 helo=tp06.long4more.com)
        by www98.totaalholding.nl with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <mjbaars1977.gcc@cyberfiber.eu>)
        id 1lE7D3-0002Xy-MK; Mon, 22 Feb 2021 10:08:53 +0100
Message-ID: <80753cbc54ef69b4fc136f791666197fc8b1f8bb.camel@cyberfiber.eu>
Subject: problems with memory allocation and the alignment check
From:   "Michael J. Baars" <mjbaars1977.gcc@cyberfiber.eu>
To:     gcc@gcc.gnu.org, linux-kernel@vger.kernel.org
Date:   Mon, 22 Feb 2021 10:08:50 +0100
Content-Type: multipart/mixed; boundary="=-goyzitPaYjgqNmdnlSez"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - www98.totaalholding.nl
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - cyberfiber.eu
X-Get-Message-Sender-Via: www98.totaalholding.nl: authenticated_id: mjbaars1977.gcc@cyberfiber.eu
X-Authenticated-Sender: www98.totaalholding.nl: mjbaars1977.gcc@cyberfiber.eu
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Originating-IP: 185.94.230.81
X-SpamExperts-Domain: out.totaalholding.nl
X-SpamExperts-Username: 185.94.230.81
Authentication-Results: totaalholding.nl; auth=pass smtp.auth=185.94.230.81@out.totaalholding.nl
X-SpamExperts-Outgoing-Class: unsure
X-SpamExperts-Outgoing-Evidence: Combined (0.32)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT9H3/Ls72yYo7+XkR8VhPVWPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5z4WkZ/TJaiaBbP2NJqrVHtfCzdNGNoLjYW00m5NbCHvI9w
 knWGobBIYos3d1n2bRGp01QLDs5L7buacvUiCMt75WCy5VkstzhnxgTXqsdmpzAZsc6MRuL9DcHa
 Zpd4we/piBIbZdykCKL9bqvChryU+RG6hze7zJVTSRhy6iTC2HkixtWJU3ux8TqCslrbPB+bgaCk
 W8nGm/sYr5TGcUrdU3OqTzTj50M7fvGTHKtUfUdqO0eWk7cK+7Mu0E3oiuU6t/uXZsD0kV3eTzZp
 3NyQ3ceUEtcBrRN3cOZEdcQPT+ZG1fUd+zsVv0CjT0c5StJuxHTyr20QCMWbZvJ/43O0eFCgjm3k
 HTZZa/hYJaCZ8fcNUETBRWLEtPQetNUJFPsVHRapBQPmCpFJcnS4eXEmh7e94ySlOOMz4vj86XPR
 uQpu60LS3Law2NOH7O/uakNbBKaJo7HrAcemBJcirJ2QJgbEDaGOkPtOluCSVXl0lI0u1JFYoaai
 GiKX/UCIqj62SBfK6J2iO8SDeqN+KIB/++DuIQUs/5JJj4C/n4CILjDyBB79EsOH+ueueKD3HVJx
 pywl7Kxcn99+Sh3aNKrBV6iFIRQAGupVupMBrep5LS25y0VVCnTvyy8sSoe9MJmYQRPlfhUIsQHw
 9jJ1gs4A07pSUabTJxCHRiVu3X4RqvdjzQ6YC7Heg3Xf7O1TOd4ek3v5uIRk1iKw5Fn4+Jv37dfW
 alqFj9toMieTbX1rThiUuff/T+y4pVTg+YdbScS3zNSNcYzh0NWvkiwQN/xdZuM7jUXIESohoO51
 xWmU8ZsLPNyWKRVhd4Yc6cD23FynV0BR+dlWoGfFQ+S+p4Yps+5OVLTtd9bM4QLzoum6fo2azxuH
 F97acinCSKJAyH+R27r9HYUzziTFhEVK8LUgzbwe5wJ+PSAukJcp0I0jTu0aTq8ZhiCjAOP7kbHh
 TW8wbVA/fmexh8/zhz5EUrcqADujzMmWyPJKS+6kHMEcy2SSgL4U/904QKV4vLt8ilQ=
X-Report-Abuse-To: spam@filter01.totaalholding.nl
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-goyzitPaYjgqNmdnlSez
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi,

I just wrote this little program to demonstrate a possible flaw in both malloc and calloc.

If I allocate a the simplest memory region from main(), one out of three optimization flags fail.
If I allocate the same region from a function, three out of three optimization flags fail.

Does someone know if this really is a flaw, and if so, is it a gcc or a kernel flaw?

Regards,
Mischa.

--=-goyzitPaYjgqNmdnlSez
Content-Disposition: attachment; filename="main.c"
Content-Type: text/x-csrc; name="main.c"; charset="UTF-8"
Content-Transfer-Encoding: base64

I2luY2x1ZGUJPHN0ZGxpYi5oPgojaW5jbHVkZQk8c3RkaW50Lmg+CgojZGVmaW5lCVJGTEFHU19S
RUdJU1RFUl9HRVQoeSkJCQkJCQlcCnsJCQkJCQkJCQlcCglhc20Jdm9sYXRpbGUJCQkJCQkJXAoJ
KAkJCQkJCQkJXAoJIglwdXNoZnEJCQkJCQlcbiIJXAoJIglwb3AJJTAJCQkJCVxuIglcCgkJCQkJ
CQkJCVwKCQk6ICI9bSIJKCogeSkgCQkJCQkJXAoJKTsJCQkJCQkJCVwKfTsKCiNkZWZpbmUJUkZM
QUdTX1JFR0lTVEVSX1NFVCh4KQkJCQkJCVwKewkJCQkJCQkJCVwKCWFzbQl2b2xhdGlsZQkJCQkJ
CQlcCgkoCQkJCQkJCQlcCgkiCXB1c2gJJTAJCQkJCVxuIglcCgkiCXBvcGZxCQkJCQkJXG4iCVwK
CQkJCQkJCQkJXAoJCToJCQkJCQkJXAoJCTogInIiCSgqIHgpIAkJCQkJCVwKCSk7CQkJCQkJCQlc
Cn07CgpzdHJ1Y3QJc3RvcmFnZQp7Cgl1aW50OF90KiBjOwp9OwoKaW50CWZ1bmN0aW9uKHN0cnVj
dCBzdG9yYWdlKiBzKQp7CglzLT5jICAgPQljYWxsb2MJKHNpemVvZih1aW50OF90KSwgOCk7CgkJ
ZnJlZQkocy0+Yyk7Cn07CgppbnQJbWFpbigpCnsKCXN0cnVjdAlzdG9yYWdlCXM7Cgl1aW50NjRf
dAkJcmZsYWdzOwoJCglSRkxBR1NfUkVHSVNURVJfR0VUKCZyZmxhZ3MpOwlyZmxhZ3MgICAgICAg
ICBePQkweDAwMDAwMDAwMDAwNDAwMDA7CglSRkxBR1NfUkVHSVNURVJfU0VUKCZyZmxhZ3MpOwoK
Ly8JZnVuY3Rpb24oJnMpOwoJCglzLmMgICAgPQljYWxsb2MJKHNpemVvZih1aW50OF90KSwgOCk7
CgkJZnJlZQkocy5jKTsKCQkKCVJGTEFHU19SRUdJU1RFUl9HRVQoJnJmbGFncyk7CXJmbGFncyAg
ICAgICAgIF49CTB4MDAwMDAwMDAwMDA0MDAwMDsKCVJGTEFHU19SRUdJU1RFUl9TRVQoJnJmbGFn
cyk7Cn0KCg==


--=-goyzitPaYjgqNmdnlSez
Content-Disposition: attachment; filename="makefile"
Content-Type: text/x-makefile; name="makefile"; charset="UTF-8"
Content-Transfer-Encoding: base64

YWxsOgoKCWdjYyAgICAgICAgLW8gbWFpbiAgICAgIG1haW4uYwoJZ2NjIC1PMiAgICAtbyBtYWlu
TzIgICAgbWFpbi5jCglnY2MgLU9mYXN0IC1vIG1haW5PZmFzdCBtYWluLmMK


--=-goyzitPaYjgqNmdnlSez--

