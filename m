Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2F423B93AC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 17:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232986AbhGAPGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 11:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232297AbhGAPF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 11:05:59 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF97DC061762
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 08:03:28 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id j1so8626140wrn.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 08:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=oc0iD59kqoC/m6VzjKMKAcJhMOIP66Lfcley3NeRvqo=;
        b=bdwznINazAJqn4/YeK6NF78H7utI8iFML7xEXEiWGGp0gql/vZQYfcq3f3IWkv5+GJ
         WpIuj9JqZUlnlWrGw2WjDpZXr9w93y4iOTNx/az8gMiaPRhIwmoL+IbcNNu1R8TjNvIa
         I+ynlL+T2R2fiHDuVUCf5c3gvkRG9EQzfsItE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=oc0iD59kqoC/m6VzjKMKAcJhMOIP66Lfcley3NeRvqo=;
        b=NAKgBGLYDQZm34yArpU5lU0JY4URV9r26vlhXqR6uHA0QzvV0es38NIbXMBZKKU7aF
         jotcrX4cPGljQNVQ7futCfCpZn+hwN11rpCWOhjTUV5tkMOFx5sOxLzQ4AqR5aFAw5/9
         mmoe6yC1ZMvUFMb0/hW7f7/EDqTku1eO839Sr4SN4Oy7gVb5IyFu/aApof5wgur5RRyH
         OKrD+T2q4xnsK5XZDiuvI4KAxHajCMeqksbugqeX5NECBEuWKQsxExg71ojofjhyStz6
         YROCmNopGdWj3fZH5u7vq2BnldqOlP726eWtYOJFbZovW03P/NSkJ2Jwd63izFsfCcbd
         158A==
X-Gm-Message-State: AOAM530OS93cHpHv43/r8jtKUj1Vk7L4yDnh9YUTnGC1Wb/SbJxpyON/
        jSXIgtQOAJwTR6YE1DkEkCn8Col94tDbrz2V4Hq1f9aBOoc0AswPLPGxC6347AS1NxuuNtBSrtZ
        32cGgESQUeqMQyLeGqGc9FY4/loDc7Wk=
X-Google-Smtp-Source: ABdhPJzk3a4JaZpYVObFEa/czvqsyQlcA3WBQbiZdpFD+h72h1cKVxMyF9450w4U7UHf2ijuAd442EtR/Bw/irOTUsU=
X-Received: by 2002:adf:e384:: with SMTP id e4mr59884wrm.317.1625151807173;
 Thu, 01 Jul 2021 08:03:27 -0700 (PDT)
MIME-Version: 1.0
From:   Tim Ross <tim.ross@broadcom.com>
Date:   Thu, 1 Jul 2021 11:01:34 -0400
Message-ID: <CAKzR7o9DG0d75RVvC=ENUiFC6Zu3AHknd3uY4HFwP+H2RHpOeA@mail.gmail.com>
Subject: Revert of no-map commits
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000339b4a05c61124c2"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000339b4a05c61124c2
Content-Type: text/plain; charset="UTF-8"

I noticed that the reverts below were made to the 4.9 and 5.4
branches, but I do not see them elsewhere (other stable branches,
latest, etc). The original commits which were subsequently reverted on
the 4.9 and 5.4 branches were causing our cable-modem drivers memremap
calls to fail so we need these reverted everywhere like they are on
the 4.9 and 5.4 branches. Is that the plan?

-Tim

ommit 6b183fbf18b91bc3c1fd02d5a48f7bc447d900cedrivers/of/fdt.c
Author: Quentin Perret <qperret@google.com>
Date:   Wed May 12 12:28:53 2021 +0000

    Revert "fdt: Properly handle "no-map" field in the memory region"

    This reverts commit fb326c6ce0dcbb6273202c6e012759754ec8538d.
    It is not really a fix, and the backport misses dependencies, which
    breaks existing platforms.

    Reported-by: Alexandre TORGUE <alexandre.torgue@foss.st.com>
    Signed-off-by: Quentin Perret <qperret@google.com>
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit 66b8853dfa3cfbbe6c3ab643b6989377ad16662a
Author: Quentin Perret <qperret@google.com>
Date:   Wed May 12 12:28:52 2021 +0000

    Revert "of/fdt: Make sure no-map does not remove already reserved regions"

    This reverts commit 3cbd3038c9155038020560729cde50588311105d.
    It is not really a fix, and the backport misses dependencies, which
    breaks existing platforms.

    Reported-by: Alexandre TORGUE <alexandre.torgue@foss.st.com>
    Signed-off-by: Quentin Perret <qperret@google.com>
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit 3cbd3038c9155038020560729cde50588311105d
Author: Nicolas Boichat <drinkcat@chromium.org>
Date:   Fri Jan 15 11:45:44 2021 +0000

    of/fdt: Make sure no-map does not remove already reserved regions

    [ Upstream commit 8a5a75e5e9e55de1cef5d83ca3589cb4899193ef ]

    If the device tree is incorrectly configured, and attempts to
    define a "no-map" reserved memory that overlaps with the kernel
    data/code, the kernel would crash quickly after boot, with no
    obvious clue about the nature of the issue.

    For example, this would happen if we have the kernel mapped at
    these addresses (from /proc/iomem):
    40000000-41ffffff : System RAM
      40080000-40dfffff : Kernel code
      40e00000-411fffff : reserved
      41200000-413e0fff : Kernel data

    And we declare a no-map shared-dma-pool region at a fixed address
    within that range:
    mem_reserved: mem_region {
            compatible = "shared-dma-pool";
            reg = <0 0x40000000 0 0x01A00000>;
            no-map;
    };

    To fix this, when removing memory regions at early boot (which is
    what "no-map" regions do), we need to make sure that the memory
    is not already reserved. If we do, __reserved_mem_reserve_reg
    will throw an error:
    [    0.000000] OF: fdt: Reserved memory: failed to reserve memory
       for node 'mem_region': base 0x0000000040000000, size 26 MiB
    and the code that will try to use the region should also fail,
    later on.

    We do not do anything for non-"no-map" regions, as memblock
    explicitly allows reserved regions to overlap, and the commit
    that this fixes removed the check for that precise reason.

    [ qperret: fixed conflicts caused by the usage of memblock_mark_nomap ]

    Fixes: 094cb98179f19b7 ("of/fdt: memblock_reserve /memreserve/
regions in the case of partial overlap")
    Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
    Reviewed-by: Stephen Boyd <swboyd@chromium.org>
    Signed-off-by: Quentin Perret <qperret@google.com>
    Link: https://lore.kernel.org/r/20210115114544.1830068-3-qperret@google.com
    Signed-off-by: Rob Herring <robh@kernel.org>
    Signed-off-by: Sasha Levin <sashal@kernel.org>

commit fb326c6ce0dcbb6273202c6e012759754ec8538d
Author: KarimAllah Ahmed <karahmed@amazon.de>
Date:   Fri Jan 15 11:45:43 2021 +0000

    fdt: Properly handle "no-map" field in the memory region

    [ Upstream commit 86588296acbfb1591e92ba60221e95677ecadb43 ]

    Mark the memory region with NOMAP flag instead of completely removing it
    from the memory blocks. That makes the FDT handling consistent with the EFI
    memory map handling.

    Cc: Rob Herring <robh+dt@kernel.org>
    Cc: Frank Rowand <frowand.list@gmail.com>
    Cc: devicetree@vger.kernel.org
    Cc: linux-kernel@vger.kernel.org
    Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
    Signed-off-by: Quentin Perret <qperret@google.com>
    Link: https://lore.kernel.org/r/20210115114544.1830068-2-qperret@google.com
    Signed-off-by: Rob Herring <robh@kernel.org>
    Signed-off-by: Sasha Levin <sashal@kernel.org>

-- 
This electronic communication and the information and any files transmitted 
with it, or attached to it, are confidential and are intended solely for 
the use of the individual or entity to whom it is addressed and may contain 
information that is confidential, legally privileged, protected by privacy 
laws, or otherwise restricted from disclosure to anyone else. If you are 
not the intended recipient or the person responsible for delivering the 
e-mail to the intended recipient, you are hereby notified that any use, 
copying, distributing, dissemination, forwarding, printing, or copying of 
this e-mail is strictly prohibited. If you received this e-mail in error, 
please return the e-mail to the sender, delete it from your computer, and 
destroy any printed copy of it.

--000000000000339b4a05c61124c2
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
THw0t6sUjczj/yAB/GqopChAF6OPA0qBoAaQnQ6V9PfAxfOfoLuZ8mkcR8bDaW1Zs6D6kjg1mtei
vWXSF+4Ius9Gs+beIVc3BF2J3edR6wg9AgMBAAGjggHWMIIB0jAOBgNVHQ8BAf8EBAMCBaAwgaMG
CCsGAQUFBwEBBIGWMIGTME4GCCsGAQUFBzAChkJodHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29t
L2NhY2VydC9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcnQwQQYIKwYBBQUHMAGGNWh0dHA6
Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwME0GA1UdIARG
MEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNv
bS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEkGA1UdHwRCMEAwPqA8oDqGOGh0dHA6Ly9jcmwuZ2xv
YmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3JsMCAGA1UdEQQZMBeBFXRp
bS5yb3NzQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9Hm
WBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUWxcCPDq5QG7h3yLYmB3YRKdgExYwDQYJKoZIhvcN
AQELBQADggEBAFRa0oMdKfIW8jzFMm0SiqDVrVBkDLrXYSEVjIVv9CcEUM+MDA+1f7opNJI3jS3v
XEu4hnTmr+9ZzqQ8Li9KelpO82KG5mOqzetcvFXvzBchlZfmTKjZVXHJzhmU2PZR482dXlnyokxF
4JSwGnPjD74a2/1zj5cOBwIa9eYvI/MmZN2JJqBs1BaqEs9+3L6tOFjnHOl1iY8c0EndQxh8Wim+
+ytwgvNsAMop3pPlrKhZIEc8Mx1Arr2KOQjh0gr8TfG2z553ubk+HKn2N2m5TBQe9O5gNZiPQ8O+
IYBYF+/S0AdX1bi+oC+b2UZy9VRdSAQQAAi9yS9x3gvdhIwJIYMxggJtMIICaQIBATBrMFsxCzAJ
BgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWdu
IEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgw/R6BI5sk+PWhkEBMwDQYJYIZIAWUDBAIB
BQCggdQwLwYJKoZIhvcNAQkEMSIEIA0j/JVdClz1oZt9O7He/JhwG+/zDUad4X9vc8V5MWT7MBgG
CSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIxMDcwMTE1MDMyN1owaQYJ
KoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggq
hkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0B
AQEFAASCAQAClVkp6DC1qI1VtOfuDnzg+lyMJx3DzxRUn3IQHDZnSoRnIEnegg6xuHtSQx4Rmv33
raDUWxFgaP3MTQvfWMYQJJmNqBA4su46YpZyPW1mvYDivSS6lXbL1y5CpivsK5iSND+dq+P0rpIh
kp5rn8r169zGtw85EPZIYe2koQJ+m+e9JQJnXUAa6SfmFI4v8H6ZwOvRjtr5OSpkp/Gc0bVfNRR1
L74glcj5YHymCeQlv7YU40J7NSZ1aqPVFkbFB2fH996D+/SeiiXlcGKbJ35Bu1PgqYUzQzGOLTmE
Js6BuE2/cKHuaQF7F82mFId3ivKJVcNC6QDYkK4Rpsm5GChg
--000000000000339b4a05c61124c2--
