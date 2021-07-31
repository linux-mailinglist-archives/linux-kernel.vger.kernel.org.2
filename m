Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4C3E3DC533
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 10:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbhGaIzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Jul 2021 04:55:52 -0400
Received: from mx.kolabnow.com ([95.128.36.41]:63904 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232299AbhGaIzu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Jul 2021 04:55:50 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTP id 88998891;
        Sat, 31 Jul 2021 10:55:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:content-type:content-type:mime-version
        :message-id:date:date:subject:subject:from:from:received
        :received:received; s=dkim20160331; t=1627721740; x=1629536141;
         bh=P0ConBhjniYirdILUZkSkCHAyHgU/sE04t2oW/ndIko=; b=gI4tRaXmThuV
        1j+d7JoT3m/OOC5Fe+Uu4UA0rRAXe1vIzWfjeqmbucw6aKLfxJ9nNc1iWTwFBVqn
        Y4SzsLgpRDAtgT0FzC8JmKwict/Hd2dmaM8CgAoCIJmY9X9f6/mmWBZX9lKs1/Ue
        3FU2GaLjdFWnzCfzt8bbBrD3LvM+4TnYgEeYCj0ENI+t/JZ/KL3vxg6jy/pUs9Su
        0m/Ctnq4a+hnnxTkAwWOkynGPXD9CesuGRT0eTNrJXrkeSpGnHk9g6e+8vj2vX66
        nko2tnMIqxddZCnXqHml9EbEbqteTATjTUaBGc0KOl2iw4ZqxxcGZxN5NcaO91ZF
        Z/BZlT7u6P7VDDUhexCmkzJBM4q8Y/8/QkqRwMkLTIVgJitG+NSsI1gy0xzEqCm+
        kC9WpXL/94dWh3KXqp5Q8Dum5FjbXutlS0+cq0of16HkAUmXg0CNGua2KaAZpiGv
        2j+dUK/WJGzvg8FnCbm02VyQnhbbK7uYGkb3xTZdHzfm8N3XQEnRc/12YUz1pnFn
        shFutxJwvIX8S6flgNsXZghmpwFWUMN1+YVJ8tDyTGbj2ommjzYoq7Bw9yyhr/xb
        Aicaxj6i7rgCzM+7CuvwwbpGo24SY42EePdVDiipvqpZGPPASNc8XOgODRRP58x1
        t7SsgCdESWKNOmYK0tn4u87KQetJGjw=
X-Virus-Scanned: amavisd-new at mykolab.com
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 tagged_above=-10 required=5
        tests=[BAYES_00=-1.9] autolearn=ham autolearn_force=no
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out002.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7wI1WrLhXk_l; Sat, 31 Jul 2021 10:55:40 +0200 (CEST)
Received: from int-mx002.mykolab.com (unknown [10.9.13.2])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTPS id 0BDDA614;
        Sat, 31 Jul 2021 10:55:39 +0200 (CEST)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx002.mykolab.com (Postfix) with ESMTPS id EE46144A4;
        Sat, 31 Jul 2021 10:55:37 +0200 (CEST)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Federico Vaga <federico.vaga@vaga.pv.it>
Subject: [PATCH 1/2] doc: align Italian translation
Date:   Sat, 31 Jul 2021 10:55:13 +0200
Message-Id: <20210731085513.11820-1-federico.vaga@vaga.pv.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Translation for the following patches

commit 0ca0d55526d3 ("docs/core-api: Consistent code style")
commit 9912d0bb9dee ("docs: process: submitting-patches.rst: avoid using ReST :doc:`foo` markup")
commit 6349469a4f3c ("Documentation/submitting-patches: Document RESEND tag on patches")
commit dbbe7c962c3a ("docs: networking: drop special stable handling")
commit 7f3f7bfbbe02 ("docs: kernel-hacking: hacking.rst: avoid using ReST :doc:`foo` markup")
commit 6ab0493dfc62 ("deprecated.rst: Include details on "no_hash_pointers" ")
commit 77167b966b7e ("docs: submitting-patches: clarify the role of LKML ")

Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
---
 .../it_IT/core-api/symbol-namespaces.rst      | 26 ++++-----
 .../it_IT/kernel-hacking/hacking.rst          |  4 +-
 .../translations/it_IT/process/deprecated.rst |  8 ++-
 .../it_IT/process/stable-kernel-rules.rst     |  6 --
 .../it_IT/process/submitting-patches.rst      | 57 ++++++++++---------
 5 files changed, 51 insertions(+), 50 deletions(-)

diff --git a/Documentation/translations/it_IT/core-api/symbol-namespaces.rst b/Documentation/translations/it_IT/core-api/symbol-namespaces.rst
index aa851a57a4b0..42f5d04e38ec 100644
--- a/Documentation/translations/it_IT/core-api/symbol-namespaces.rst
+++ b/Documentation/translations/it_IT/core-api/symbol-namespaces.rst
@@ -42,15 +42,15 @@ nomi: EXPORT_SYMBOL_NS() ed EXPORT_SYMBOL_NS_GPL(). Queste macro richiedono un
 argomento aggiuntivo: lo spazio dei nomi.
 Tenete presente che per via dell'espansione delle macro questo argomento deve
 essere un simbolo di preprocessore. Per esempio per esportare il
-simbolo `usb_stor_suspend` nello spazio dei nomi `USB_STORAGE` usate::
+simbolo ``usb_stor_suspend`` nello spazio dei nomi ``USB_STORAGE`` usate::
 
 	EXPORT_SYMBOL_NS(usb_stor_suspend, USB_STORAGE);
 
 Di conseguenza, nella tabella dei simboli del kernel ci sarà una voce
-rappresentata dalla struttura `kernel_symbol` che avrà il campo
-`namespace` (spazio dei nomi) impostato. Un simbolo esportato senza uno spazio
-dei nomi avrà questo campo impostato a `NULL`. Non esiste uno spazio dei nomi
-di base. Il programma `modpost` e il codice in kernel/module.c usano lo spazio
+rappresentata dalla struttura ``kernel_symbol`` che avrà il campo
+``namespace`` (spazio dei nomi) impostato. Un simbolo esportato senza uno spazio
+dei nomi avrà questo campo impostato a ``NULL``. Non esiste uno spazio dei nomi
+di base. Il programma ``modpost`` e il codice in kernel/module.c usano lo spazio
 dei nomi, rispettivamente, durante la compilazione e durante il caricamento
 di un modulo.
 
@@ -65,7 +65,7 @@ ed EXPORT_SYMBOL_GPL() che non specificano esplicitamente uno spazio dei nomi.
 
 Ci sono molti modi per specificare questo simbolo di preprocessore e il loro
 uso dipende dalle preferenze del manutentore di un sottosistema. La prima
-possibilità è quella di definire il simbolo nel `Makefile` del sottosistema.
+possibilità è quella di definire il simbolo nel ``Makefile`` del sottosistema.
 Per esempio per esportare tutti i simboli definiti in usb-common nello spazio
 dei nomi USB_COMMON, si può aggiungere la seguente linea in
 drivers/usb/common/Makefile::
@@ -97,7 +97,7 @@ USB_STORAGE usando la seguente dichiarazione::
 
 	MODULE_IMPORT_NS(USB_STORAGE);
 
-Questo creerà un'etichetta `modinfo` per ogni spazio dei nomi
+Questo creerà un'etichetta ``modinfo`` per ogni spazio dei nomi
 importato. Un risvolto di questo fatto è che gli spazi dei
 nomi importati da un modulo possono essere ispezionati tramite
 modinfo::
@@ -116,7 +116,7 @@ mancanti.
 4. Caricare moduli che usano simboli provenienti da spazi dei nomi
 ==================================================================
 
-Quando un modulo viene caricato (per esempio usando `insmod`), il kernel
+Quando un modulo viene caricato (per esempio usando ``insmod``), il kernel
 verificherà la disponibilità di ogni simbolo usato e se lo spazio dei nomi
 che potrebbe contenerli è stato importato. Il comportamento di base del kernel
 è di rifiutarsi di caricare quei moduli che non importano tutti gli spazi dei
@@ -144,22 +144,22 @@ Lo scenario tipico di chi scrive un modulo potrebbe essere::
 
 	- scrivere codice che dipende da un simbolo appartenente ad uno spazio
 	  dei nomi non importato
-	- eseguire `make`
+	- eseguire ``make``
 	- aver notato un avviso da modpost che parla di un'importazione
 	  mancante
-	- eseguire `make nsdeps` per aggiungere import nel posto giusto
+	- eseguire ``make nsdeps`` per aggiungere import nel posto giusto
 
 Per i manutentori di sottosistemi che vogliono aggiungere uno spazio dei nomi,
-l'approccio è simile. Di nuovo, eseguendo `make nsdeps` aggiungerà le
+l'approccio è simile. Di nuovo, eseguendo ``make nsdeps`` aggiungerà le
 importazioni mancanti nei moduli inclusi nel kernel::
 
 	- spostare o aggiungere simboli ad uno spazio dei nomi (per esempio
 	  usando EXPORT_SYMBOL_NS())
-	- eseguire `make` (preferibilmente con allmodconfig per coprire tutti
+	- eseguire ``make`` (preferibilmente con allmodconfig per coprire tutti
 	  i moduli del kernel)
 	- aver notato un avviso da modpost che parla di un'importazione
 	  mancante
-	- eseguire `make nsdeps` per aggiungere import nel posto giusto
+	- eseguire ``make nsdeps`` per aggiungere import nel posto giusto
 
 Potete anche eseguire nsdeps per moduli esterni. Solitamente si usa così::
 
diff --git a/Documentation/translations/it_IT/kernel-hacking/hacking.rst b/Documentation/translations/it_IT/kernel-hacking/hacking.rst
index f6beb385b4ac..b4ea00f1b583 100644
--- a/Documentation/translations/it_IT/kernel-hacking/hacking.rst
+++ b/Documentation/translations/it_IT/kernel-hacking/hacking.rst
@@ -634,7 +634,7 @@ Definita in ``include/linux/export.h``
 
 Questa è una variate di `EXPORT_SYMBOL()` che permette di specificare uno
 spazio dei nomi. Lo spazio dei nomi è documentato in
-:doc:`../core-api/symbol-namespaces`
+Documentation/translations/it_IT/core-api/symbol-namespaces.rst.
 
 :c:func:`EXPORT_SYMBOL_NS_GPL()`
 --------------------------------
@@ -643,7 +643,7 @@ Definita in ``include/linux/export.h``
 
 Questa è una variate di `EXPORT_SYMBOL_GPL()` che permette di specificare uno
 spazio dei nomi. Lo spazio dei nomi è documentato in
-:doc:`../core-api/symbol-namespaces`
+Documentation/translations/it_IT/core-api/symbol-namespaces.rst.
 
 Procedure e convenzioni
 =======================
diff --git a/Documentation/translations/it_IT/process/deprecated.rst b/Documentation/translations/it_IT/process/deprecated.rst
index 07c79d4bafca..987f45ee1804 100644
--- a/Documentation/translations/it_IT/process/deprecated.rst
+++ b/Documentation/translations/it_IT/process/deprecated.rst
@@ -183,9 +183,11 @@ di Linus:
   affrontare il giudizio di Linus, allora forse potrai usare "%px",
   assicurandosi anche di averne il permesso.
 
-Infine, sappi che un cambio in favore di "%p" con hash `non verrà
-accettato
-<https://lore.kernel.org/lkml/CA+55aFwieC1-nAs+NFq9RTwaR8ef9hWa4MjNBWL41F-8wM49eA@mail.gmail.com/>`_.
+Potete disabilitare temporaneamente l'hashing di "%p" nel caso in cui questa
+funzionalità vi sia d'ostacolo durante una sessione di debug. Per farlo
+aggiungete l'opzione di debug "`no_hash_pointers
+<https://git.kernel.org/linus/5ead723a20e0447bc7db33dc3070b420e5f80aa6>`_" alla
+riga di comando del kernel.
 
 Vettori a dimensione variabile (VLA)
 ------------------------------------
diff --git a/Documentation/translations/it_IT/process/stable-kernel-rules.rst b/Documentation/translations/it_IT/process/stable-kernel-rules.rst
index 283d62541c4f..83f48afe48b9 100644
--- a/Documentation/translations/it_IT/process/stable-kernel-rules.rst
+++ b/Documentation/translations/it_IT/process/stable-kernel-rules.rst
@@ -41,12 +41,6 @@ Regole sul tipo di patch che vengono o non vengono accettate nei sorgenti
 Procedura per sottomettere patch per i sorgenti -stable
 -------------------------------------------------------
 
- - Se la patch contiene modifiche a dei file nelle cartelle net/ o drivers/net,
-   allora seguite le linee guida descritte in
-   :ref:`Documentation/translations/it_IT/networking/netdev-FAQ.rst <it_netdev-FAQ>`;
-   ma solo dopo aver verificato al seguente indirizzo che la patch non sia
-   già in coda:
-   https://patchwork.kernel.org/bundle/netdev/stable/?state=*
  - Una patch di sicurezza non dovrebbero essere gestite (solamente) dal processo
    di revisione -stable, ma dovrebbe seguire le procedure descritte in
    :ref:`Documentation/translations/it_IT/admin-guide/security-bugs.rst <it_securitybugs>`.
diff --git a/Documentation/translations/it_IT/process/submitting-patches.rst b/Documentation/translations/it_IT/process/submitting-patches.rst
index ded95048b9a8..458d9d24b9c0 100644
--- a/Documentation/translations/it_IT/process/submitting-patches.rst
+++ b/Documentation/translations/it_IT/process/submitting-patches.rst
@@ -14,14 +14,15 @@ una certa familiarità col "sistema".  Questo testo è una raccolta di
 suggerimenti che aumenteranno significativamente le probabilità di vedere le
 vostre patch accettate.
 
-Questo documento contiene un vasto numero di suggerimenti concisi.  Per
-maggiori dettagli su come funziona il processo di sviluppo del kernel leggete
-:doc:`development-process`.
-Leggete anche :doc:`submit-checklist` per una lista di punti da
-verificare prima di inviare del codice.  Se state inviando un driver,
-allora leggete anche :doc:`submitting-drivers`; per delle patch
+Questo documento contiene un vasto numero di suggerimenti concisi. Per maggiori
+dettagli su come funziona il processo di sviluppo del kernel leggete
+Documentation/translations/it_IT/process/development-process.rst. Leggete anche
+Documentation/translations/it_IT/process/submit-checklist.rst per una lista di
+punti da verificare prima di inviare del codice. Se state inviando un driver,
+allora leggete anche
+Documentation/translations/it_IT/process/submitting-drivers.rst; per delle patch
 relative alle associazioni per Device Tree leggete
-:doc:`submitting-patches`.
+Documentation/translations/it_IT/process/submitting-patches.rst.
 
 Questa documentazione assume che sappiate usare ``git`` per preparare le patch.
 Se non siete pratici di ``git``, allora è bene che lo impariate;
@@ -193,7 +194,7 @@ ed integrate.
 ---------------------------------------------
 
 Controllate che la vostra patch non violi lo stile del codice, maggiori
-dettagli sono disponibili in :ref:`Documentation/translations/it_IT/process/coding-style.rst <it_codingstyle>`.
+dettagli sono disponibili in Documentation/translations/it_IT/process/coding-style.rst.
 Non farlo porta semplicemente a una perdita di tempo da parte dei revisori e
 voi vedrete la vostra patch rifiutata, probabilmente senza nemmeno essere stata
 letta.
@@ -230,13 +231,13 @@ scripts/get_maintainer.pl può esservi d'aiuto.  Se non riuscite a trovare un
 manutentore per il sottosistema su cui state lavorando, allora Andrew Morton
 (akpm@linux-foundation.org) sarà la vostra ultima possibilità.
 
-Normalmente, dovreste anche scegliere una lista di discussione a cui inviare
-la vostra serie di patch.  La lista di discussione linux-kernel@vger.kernel.org
-è proprio l'ultima spiaggia, il volume di email su questa lista fa si che
-diversi sviluppatori non la seguano.  Guardate nel file MAINTAINERS per trovare
-la lista di discussione dedicata ad un sottosistema; probabilmente lì la vostra
-patch riceverà molta più attenzione.  Tuttavia, per favore, non spammate le
-liste di discussione che non sono interessate al vostro lavoro.
+Normalmente, dovreste anche scegliere una lista di discussione a cui inviare la
+vostra serie di patch. La lista di discussione linux-kernel@vger.kernel.org
+dovrebbe essere usata per inviare tutte le patch, ma il traffico è tale per cui
+diversi sviluppatori la trascurano. Guardate nel file MAINTAINERS per trovare la
+lista di discussione dedicata ad un sottosistema; probabilmente lì la vostra
+patch riceverà molta più attenzione. Tuttavia, per favore, non spammate le liste
+di discussione che non sono interessate al vostro lavoro.
 
 Molte delle liste di discussione relative al kernel vengono ospitate su
 vger.kernel.org; potete trovare un loro elenco alla pagina
@@ -257,7 +258,7 @@ embargo potrebbe essere preso in considerazione per dare il tempo alle
 distribuzioni di prendere la patch e renderla disponibile ai loro utenti;
 in questo caso, ovviamente, la patch non dovrebbe essere inviata su alcuna
 lista di discussione pubblica. Leggete anche
-:doc:`/admin-guide/security-bugs`.
+Documentation/admin-guide/security-bugs.rst.
 
 Patch che correggono bachi importanti su un kernel già rilasciato, dovrebbero
 essere inviate ai manutentori dei kernel stabili aggiungendo la seguente riga::
@@ -266,12 +267,7 @@ essere inviate ai manutentori dei kernel stabili aggiungendo la seguente riga::
 
 nella vostra patch, nell'area dedicata alle firme (notate, NON come destinatario
 delle e-mail).  In aggiunta a questo file, dovreste leggere anche
-:ref:`Documentation/translations/it_IT/process/stable-kernel-rules.rst <it_stable_kernel_rules>`
-
-Tuttavia, notate, che alcuni manutentori di sottosistema preferiscono avere
-l'ultima parola su quali patch dovrebbero essere aggiunte ai kernel stabili.
-La rete di manutentori, in particolare, non vorrebbe vedere i singoli
-sviluppatori aggiungere alle loro patch delle righe come quella sopracitata.
+Documentation/translations/it_IT/process/stable-kernel-rules.rst.
 
 Se le modifiche hanno effetti sull'interfaccia con lo spazio utente, per favore
 inviate una patch per le pagine man ai manutentori di suddette pagine (elencati
@@ -330,7 +326,7 @@ così la possibilità che il vostro allegato-MIME venga accettato.
 Eccezione: se il vostro servizio di posta storpia le patch, allora qualcuno
 potrebbe chiedervi di rinviarle come allegato MIME.
 
-Leggete :doc:`/translations/it_IT/process/email-clients`
+Leggete Documentation/translations/it_IT/process/email-clients.rst
 per dei suggerimenti sulla configurazione del programmi di posta elettronica
 per l'invio di patch intatte.
 
@@ -351,7 +347,7 @@ richiede molto tempo, e a volte i revisori diventano burberi.  Tuttavia, anche
 in questo caso, rispondete con educazione e concentratevi sul problema che
 hanno evidenziato.
 
-Leggete :doc:`/translations/it_IT/process/email-clients` per
+Leggete Documentation/translations/it_IT/process/email-clients.rst per
 le raccomandazioni sui programmi di posta elettronica e l'etichetta da usare
 sulle liste di discussione.
 
@@ -369,6 +365,16 @@ aver inviato le patch correttamente.  Aspettate almeno una settimana prima di
 rinviare le modifiche o sollecitare i revisori - probabilmente anche di più
 durante la finestra d'integrazione.
 
+Potete anche rinviare la patch, o la serie di patch, dopo un paio di settimane
+aggiungendo la parola "RESEND" nel titolo::
+
+    [PATCH Vx RESEND] sub/sys: Condensed patch summary
+
+Ma non aggiungete "RESEND" quando state sottomettendo una versione modificata
+della vostra patch, o serie di patch - "RESEND" si applica solo alla
+sottomissione di patch, o serie di patch, che non hanno subito modifiche
+dall'ultima volta che sono state inviate.
+
 Aggiungete PATCH nell'oggetto
 -----------------------------
 
@@ -795,8 +801,7 @@ Greg Kroah-Hartman, "Come scocciare un manutentore di un sottosistema"
 No!!!! Basta gigantesche bombe patch alle persone sulla lista linux-kernel@vger.kernel.org!
   <https://lore.kernel.org/r/20050711.125305.08322243.davem@davemloft.net>
 
-Kernel Documentation/translations/it_IT/process/coding-style.rst:
-  :ref:`Documentation/translations/it_IT/process/coding-style.rst <it_codingstyle>`
+Kernel Documentation/translations/it_IT/process/coding-style.rst.
 
 E-mail di Linus Torvalds sul formato canonico di una patch:
   <https://lore.kernel.org/r/Pine.LNX.4.58.0504071023190.28951@ppc970.osdl.org>
-- 
2.32.0.93.g670b81a890

