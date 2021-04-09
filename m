Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59BE4359E4B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 14:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233659AbhDIMGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 08:06:53 -0400
Received: from sender4-pp-o94.zoho.com ([136.143.188.94]:25446 "EHLO
        sender4-pp-o94.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233009AbhDIMGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 08:06:52 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1617969094; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=QupKTEiu0XsE6VxXmmoHu4ZYyPYMYSzHha5bV+I74tk+FjUDb4ZW4LF9OBmoANFEcf7SACl5PPfFuhpLC6wEVp+ZRtgKMwAJ5qql/VyBhUPOPqkNzPAv5vF69L5ofcLqkLaWHmWk5fkAfv49tx4M7mxHS5gv0qfFrq5XImrQErc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1617969094; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=N/9B1dYoDfR/57lnYBNycXGu5h3aWGc9t16ZPr/cPEE=; 
        b=SLOKFD32CVrY+V3wazL8DJws1kcqnPGbBk3zUxosH3Vs515+82Bxhm6bXYfB9duFE6gwHPze4HbZ/6bzacNuXVa9zcfoKMWoCH3q+B2vWvDTolNxiAFZO7KA0kUCzgcskmMChQukS190tJNVpq7AHrtUoUp5YyV9gV6rDJjXBbg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=ragasgupta@zoho.com;
        dmarc=pass header.from=<ragasgupta@zoho.com> header.from=<ragasgupta@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=date:from:to:message-id:in-reply-to:references:subject:mime-version:content-type:user-agent; 
  b=BDpFN58L4SwA+bS7TnE4VB+aCacrXT5IlMYlR8/LX4PSKG/aNRQMjZSVXo8Iv2qaSLd0lbVZilvQ
    UraYK1Mh2Q2qV/gpcrJ+ZEtqV2yxRYuNEBHYcWNNv5b6VnUgK1l6  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1617969094;
        s=zm2020; d=zoho.com; i=ragasgupta@zoho.com;
        h=Date:From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=N/9B1dYoDfR/57lnYBNycXGu5h3aWGc9t16ZPr/cPEE=;
        b=KUQFkOYk4l1GSTzSE9jg6FF/mOPLSqP1ypeNKuYOMU8yBf5enhdOZSc5whkymLjg
        Ap3UDYNku0KeVLrLp462TXclke6Zm77etEFETWB9VToWbMOjQ2gQ50WDHScYEpN+xsL
        xaxSwBXXSm9MRQWFNkeJQDKYOlThncwi6Tc5lTsc=
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1617969093807653.6350490836769; Fri, 9 Apr 2021 04:51:33 -0700 (PDT)
Received: from  [34.98.205.117] by mail.zoho.com
        with HTTP;Fri, 9 Apr 2021 04:51:33 -0700 (PDT)
Date:   Fri, 09 Apr 2021 17:21:33 +0530
From:   ragas gupta <ragasgupta@zoho.com>
To:     "linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <178b6791c98.d80447e9132662.7749028549057325472@zoho.com>
In-Reply-To: <178b6770c4e.111847ae9132647.4668617079131551849@zoho.com>
References: <178b641aeb9.ec6e71c9132052.6218745065153370962@zoho.com> <178b67644d1.107ad1ec3132641.8033434734705028022@zoho.com> <178b6770c4e.111847ae9132647.4668617079131551849@zoho.com>
Subject: Fwd: Function Level Reset notification to PCIe device driver
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello,=20
 =20
 This query is regarding Function level reset feature for SRIOV.=20
 As per code in Linux PCIe driver the function level reset is done by writi=
ng =E2=80=9C1=E2=80=9D to =E2=80=9Creset=E2=80=9D under sysfs interface.=20
 e.g. =E2=80=9Cecho 1 > /sys/bus/pci/devices/<interface id> /reset =E2=80=
=9C=20
 =20
 As function level reset is not triggered via the PCIe device driver how PC=
Ie device driver can get the notification of the function level reset(FLR)?=
=20

