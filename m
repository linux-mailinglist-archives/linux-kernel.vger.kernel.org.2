Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D72F841F724
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 23:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355702AbhJAV4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 17:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbhJAV4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 17:56:12 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0139C06177E
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 14:54:27 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id na16-20020a17090b4c1000b0019f5bb661f9so4291903pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 14:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Y2F9tIAyLMuMdvZ+xZbB5A4lCV2UGNUjjsvsd+NvfA8=;
        b=WreVklBggxei96NbU8ryj3miFwVUGz33146Bjjpotu/SgaGDVHfMAxd66UfUwDGeK2
         s6ztopBoSJDInYcU7oXlxkZz1BcBoxmPBBI1xPO/uMs79M0MRKCX5sFKdGExo9ssjWpK
         aE6MRoCvHIwz9DG8dka2mJRnqAp924032T3GXpgYmHp1CPj6C+K6WIQzTfBJBnKweNmM
         ZLVFWfxC0mwGtw/UcxJJEDh0joqnJ+0ktuCjCzKpjizgcKssBE/CDRid6aYllv7PeywG
         xO0osNLhBVxCzmiJ9NI6dqYf1f2X1hN0ikVutmLEFwaZLmsm5kFgNsOhgEjwEAXdxrvx
         KwkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=Y2F9tIAyLMuMdvZ+xZbB5A4lCV2UGNUjjsvsd+NvfA8=;
        b=v+Urpv5M9P0CLoaELcAFymDzj4GsWxk51xaT++f8csvAs0Nrw9vZD0TdUAqdOVa6st
         1vslTPZLXRDDa4oGTBDV9asmuKk6ZeuLpMv9Mj1EQ77YIwDWiidzGBxnhN0yG2FezRpW
         c7adukYA6Cas2noM7BjXSWskFPWYxXL70QBJl4PvAiHWeFFRrtiOFMhpwfv5RfFia56k
         fFQDkIhBQ9L21czLKSI6LjxwS3e+AFvdMWevJ1m37xR/lCySh6CAoYXitjC5layms6pR
         ewCHxXGnbrJruCCUnxS1RE0Etg8FNFi1tqnfK95p2ilKxBJnRpyHv9k548pZSnCYFt4J
         5dTg==
X-Gm-Message-State: AOAM531OQUTZ9IEwAidXXgUzzt0l6eV32mObhuUr16xcELMFUvChG2f2
        3vEhhOK57IqCr6PDQaXaFdWNZdOaV1QtcJ4wJjM=
X-Google-Smtp-Source: ABdhPJy7yOHZBox9/6AbjfqaThtyOQ9uxtmnaGDA9onO8iCyLkeznb0D80Fd8fLfFfJbcoq9QlAEVLVXicBeicZvrLo=
X-Received: by 2002:a17:902:d2c6:b0:13e:9bc9:1ae3 with SMTP id
 n6-20020a170902d2c600b0013e9bc91ae3mr11077plc.87.1633125267243; Fri, 01 Oct
 2021 14:54:27 -0700 (PDT)
MIME-Version: 1.0
Sender: manuellawarlordibrahim7@gmail.com
Received: by 2002:a05:6a10:1d8f:0:0:0:0 with HTTP; Fri, 1 Oct 2021 14:54:26
 -0700 (PDT)
From:   manuella warlord ibrahim <manuellawarlordibrahim@gmail.com>
Date:   Fri, 1 Oct 2021 14:54:26 -0700
X-Google-Sender-Auth: Bnsb_7B77iLKsgevwNMHaB_tfrY
Message-ID: <CA+ZVOZjFXqv694uoVdda_6jNtYOz1W2w1ZHX0SHcxDKtPJbTyg@mail.gmail.com>
Subject: =?UTF-8?Q?aspetter=C3=B2_di_leggerti=21=21=21?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Carissimo,

So che questa e-mail ti sorprender=C3=A0 poich=C3=A9 non ci siamo conosciut=
i o
incontrati prima di considerare il fatto che ho trovato il tuo
contatto e-mail tramite Internet alla ricerca di una persona di
fiducia che possa aiutarmi.

Sono la signorina Manuella Warlord Ibrahim Coulibaly, una donna di 24
anni della Repubblica della Costa d'Avorio, Africa occidentale, figlia
del defunto capo Sgt. Warlord Ibrahim Coulibaly (alias Generale IB).
Il mio defunto padre era un noto capo della milizia della Costa
d'Avorio. =C3=88 morto gioved=C3=AC 28 aprile 2011 a seguito di uno scontro=
 con
le forze repubblicane della Costa d'Avorio (FRCI). Sono costretto a
contattarvi a causa dei maltrattamenti che sto ricevendo dalla mia
matrigna.

Aveva in programma di portarmi via tutti i tesori e le propriet=C3=A0 del
mio defunto padre dopo la morte inaspettata del mio amato padre. Nel
frattempo volevo viaggiare in Europa, ma lei nasconde il mio
passaporto internazionale e altri documenti preziosi. Per fortuna non
ha scoperto dove tenevo il fascicolo di mio padre che conteneva
documenti importanti. Ora mi trovo attualmente nella Missione in
Ghana.

Sto cercando relazioni a lungo termine e assistenza agli investimenti.
Mio padre di beata memoria ha depositato la somma di 27,5 milioni di
dollari in una banca ad Accra in Ghana con il mio nome come parente
pi=C3=B9 prossimo. Avevo contattato la Banca per liquidare la caparra ma il
Direttore di Filiale mi ha detto che essendo rifugiato, il mio status
secondo la legge locale non mi autorizza ad effettuare l'operazione.
Tuttavia, mi ha consigliato di fornire un fiduciario che star=C3=A0 a mio
nome. Avrei voluto informare la mia matrigna di questo deposito ma
temo che non mi offrir=C3=A0 nulla dopo lo svincolo del denaro.

Pertanto, decido di cercare il tuo aiuto per trasferire i soldi sul
tuo conto bancario mentre mi trasferir=C3=B2 nel tuo paese e mi sistemer=C3=
=B2
con te. Poich=C3=A9 hai indicato il tuo interesse ad aiutarmi, ti dar=C3=B2=
 il
numero di conto e il contatto della banca dove il mio amato padre
defunto ha depositato i soldi con il mio nome come parente pi=C3=B9
prossimo. =C3=88 mia intenzione risarcirti con il 40% del denaro totale per
la tua assistenza e il saldo sar=C3=A0 il mio investimento in qualsiasi
impresa redditizia che mi consiglierai poich=C3=A9 non hai alcuna idea
sugli investimenti esteri. Per favore, tutte le comunicazioni devono
avvenire tramite questo indirizzo e-mail per scopi riservati
(manuellawarlordibrahimw@gmail.com).

La ringrazio molto in attesa di una sua rapida risposta. Ti dar=C3=B2 i
dettagli nella mia prossima mail dopo aver ricevuto la tua mail di
accettazione per aiutarmi,

Cordiali saluti
Miss manuella signore della guerra Ibrahim Coulibaly
(manuellawarlordibrahimw@gmail.com)
