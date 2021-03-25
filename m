Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2D003493E4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 15:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbhCYOWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 10:22:18 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:36053 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230078AbhCYOVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 10:21:42 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id BF7D05C0074;
        Thu, 25 Mar 2021 10:21:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 25 Mar 2021 10:21:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=allmail.cc; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-type; s=fm3; bh=/1uwORJgtqX2AKdFgSIUIsZCA9
        bG2x+J5XTahF1nYqM=; b=xec8mjI27dwJcdAlPaoxvG2+l3NmM6r9JNH3casyzK
        9msC/Mr+fEb/BKnjovXif3gfnW7cr0p70Cl0HsRPv/7ujZnXcpzVALbZTqatlWVp
        pjcbw7l5BvlzMUoCvYWCXApv9pyNVaWAo1NgUtRrXANJbjSlqSjT3U33fNWu6myZ
        2KXc5YPacCimc4DaIPbgqxuMgt0IOTnr/Yv7NrzZP+yqiydmDwcE6FA1nusiPPQL
        zmmDSUDw/Oz4hY0MzzLRf6TQow3MUGMl2uX2Zv3VZmX4uTHhvyvUhvsCzOQ7xscX
        Rn4nveBrTGBDsppq+ceaKUYwvMMZX9C35ByOujoYxiEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=/1uwOR
        JgtqX2AKdFgSIUIsZCA9bG2x+J5XTahF1nYqM=; b=kJ0/Hsl1TlV0sXNne8ZLOu
        iP8L/u46DS57yYZPEZqiUPvEDdCdrfOTa6ftZU7p1TQoKcYh1OTNscM/JqJOaGZc
        59d5GJhl1evGZaxpcAL1EXDYcDx2uuj6f1mH/1rqtyORJhaOJo9agw1ky22MShIH
        lM6kRWAjiIy+BytId1IooNXyAOyzxtzHJPJfr61u1kn6iTr3BCd8KXpa5V8dZsJW
        0kFaDhZtMqXXEIuWaTAcL0Xzmo4rlpu8wCC2rvucS3rjG8AdXqwFCc29/F8Ic/m1
        WqUr7L8f+n4W5doEaNYDj8o2dRkbF8pyZt8Cl2sEdy1pDvuSYgpT2hvGn1jVwgtg
        ==
X-ME-Sender: <xms:dJxcYFGhljANUck8-beGRlpeTXTgjB_KfctoNVTfbtLoDPrgCxXHFw>
    <xme:dJxcYLFEM2CsMSN8TOAbSp8CbA1ZmzyvA3brYbxlfaVrzghv4NQ-FSE1b3qQEAbWV
    0nwqxhz1Is-6T3HQg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudehtddgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdludehmdenucfjughrpefhvffufffokfgjfhggtgesghdtmherredt
    jeenucfhrhhomhepfdgkihcujggrnhdfuceoiihirdihrghnsegrlhhlmhgrihhlrdgttg
    eqnecuggftrfgrthhtvghrnhepudfhueeiveeifeevgfethfdvteekteelgeeludelkefh
    ieefkeelueduheehfeeinecukfhppedvtdelrdeirdejuddrvddufeenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhesrghllhhm
    rghilhdrtggt
X-ME-Proxy: <xmx:dJxcYDRk52USQcwf1KOFPyj_QbjuQ2RjA39BWVPcznHs4vJSv1x2ZQ>
    <xmx:dJxcYMLYhM1ppUodsefW9dZQbo1sH1vni4zOk_EF8BdnVIFDa0MbSg>
    <xmx:dJxcYOaa9OmjYnKliQCiE2m2OuF4UiLBNNeLEG0xHNVzEDIobCB25g>
    <xmx:dZxcYG7PEX0f78dFw-_3JVnfvil22vFPzbDC9AildPONbYR5ZMI_QA>
Received: from [10.2.50.1] (209-6-71-213.s2259.c3-0.abr-cbr1.sbo-abr.ma.cable.rcncustomer.com [209.6.71.213])
        by mail.messagingengine.com (Postfix) with ESMTPA id AD1CC1080073;
        Thu, 25 Mar 2021 10:21:40 -0400 (EDT)
From:   "Zi Yan" <zi.yan@allmail.cc>
To:     "Miaohe Lin" <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 0/3] Cleanup for khugepaged
Date:   Thu, 25 Mar 2021 10:21:28 -0400
X-Mailer: MailMate (1.14r5757)
Message-ID: <5A180A76-511A-4094-A54A-ED8275B36A60@allmail.cc>
In-Reply-To: <20210325135647.64106-1-linmiaohe@huawei.com>
References: <20210325135647.64106-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
 boundary="=_MailMate_53BA68FD-D858-4E2E-97C6-386E8D00805A_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 3156 and 4880).

--=_MailMate_53BA68FD-D858-4E2E-97C6-386E8D00805A_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 25 Mar 2021, at 9:56, Miaohe Lin wrote:

> Hi all,
> This series contains cleanups to remove unnecessary out label and
> meaningless !pte_present() check. Also use helper function to simplify
> the code. More details can be found in the respective changelogs.
> Thanks!
>
> Miaohe Lin (3):
>   khugepaged: use helper function range_in_vma() in
>     collapse_pte_mapped_thp()
>   khugepaged: remove unnecessary out label in collapse_huge_page()
>   khugepaged: remove meaningless !pte_present() check in
>     khugepaged_scan_pmd()
>
>  mm/khugepaged.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)

All looks good to me. Thanks.

Reviewed-by: Zi Yan <ziy@nvidia.com>

=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_53BA68FD-D858-4E2E-97C6-386E8D00805A_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJGBAEBCgAwFiEEycohpi8xVoF1thvbLf9QgFMZricFAmBcnGgSHHppLnlhbkBh
bGxtYWlsLmNjAAoJEC3/UIBTGa4n0jkP/11ZJi7G0LgB+zPsOG/TRoxFafDBMoFx
stJ8+gZgyem9JN2kxPaf/SRY8RA8xPZ80KqqHuX4RUeJk+bu5p7PvAjirZSmZ+yj
ARrIiXbqm7ObToE+5YenllPV9XSrjHpTZFtZ0GTGqblylzeZsp2XuECyOTCA4zzC
MAQIXwGUTfZ3ZOXt6JUu+3vzmrrR2j9FTTtJKk8lOzzIB+Oo4Ubc+/HAJs260ZuC
j64BbXkL58w5PmbCt9ZzkIGreg5OzNEVxYofNkhKQqla4Eo/kMNxBvfE1XW7GN4H
BoSy1eq2LW55QfxPjxzONx5JZG/GkSOHuXrU7P0pkqynqvqwFH6iKDzsQpmPhWyb
UmC281qDRJuRCszd2Si90jn098vZPtyRxP/j9Udh3mXn1vD1T4W3/YDV4MLlvNvW
nH6u9ifxNn2qL5BzJSZCTMBv68gJcbJIDqZ4C6TPEj1FZyScFKMS/SIKu24SWCCj
sBrd9DjBAjV41tq/+1Z1Y0uFFNtUw+528nfWQZ46DbJcuk38TJgwsemFIz8hwWik
N1OzZ7A7PmWIpLJRrSEF0GRn31/gzlX/cFx+K3NLFFVmtQR5dGsz/lfZCSsFn4/j
fhIG1SzKYXx9bBP1cZPWXXxictJBhcy7g7rXJGgiqNTynP1liklbIS4jHRyPqYbb
tj1K0HqIdw09
=cEf/
-----END PGP SIGNATURE-----

--=_MailMate_53BA68FD-D858-4E2E-97C6-386E8D00805A_=--
